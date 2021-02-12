# Generates jobs for importing episodes from an RSS feed
class ImportRssFeedWorker
  include Sidekiq::Worker

  # TODO: ideally we would verify the data that we're seeing
  # should we use feedjira? or do it manually with # data = Hash.from_xml(xml)?
  def perform(page_id, url)
    page = Page.find(page_id)

    # fetch and parse the RSS feed
    xml = HTTParty.get(url).body
    feed = parse(xml)
    image_url = feed.try(:itunes_image) || feed.try(:image)

    # enqueue worker to attach a logo
    ::ImportLogoWorker.perform_async(page.id, image_url) if image_url

    # iterate over the entries and make posts/podcast episodes
    # perhaps we can limit the number of episodes for free users?
    # TODO: most of this is repeated from the check RSS feed worker
    feed.entries.each do |entry|
      # set up attributes
      post_params = {
        page_id: page.id,
        postable_type: 'AudioPost',
        publish_time: entry.published,
        slug: "#{entry.title.parameterize}-#{SecureRandom.hex(5)}",
        postable_attributes: {
          title: entry.title,
          content: entry.summary,
          imported: true,
          guid: entry.entry_id,
          publish_time: entry.published,
        }
      }

      # assign attributes
      post = Post.new(post_params)
      post.save!

      # either override default Shrine behavior for externally-hosted files
      # or enqueue a worker to import audio to s3
      if page.externally_hosted
        Audio.new.tap do |a|
          a.attachable_type = 'AudioPost'
          a.attachable_id = post.postable_id
          a.label = 'podcast_episode'
          a.file_data = {
            id: entry.enclosure_url,
            storage: 'external',
            metadata: {
              size: entry.enclosure_length,
              filename: entry.enclosure_url.split('/').last.split('?').first,
              mime_type: entry.enclosure_type,
              length: entry.itunes_duration,
            }
          }.to_json
          a.save
        end
      else
        ::ImportAudioWorker.perform_async(post.postable_id, entry.enclosure_url)
      end
    end
  end

  # I disagree with the priority order that FeedJira uses for its various parsers. instead
  # of relying on them, we detect if the feed includes iTunes tags and use the the iTunes
  # parser if they are present. otherwise, we raise an error. eventually, we will allow
  # FeedJira to select the processor—but that will require some adjustment to the script.
  def parse(xml)
    start_of_doc = xml.slice(0, 2000)

    if includes_itunes_tags?(start_of_doc)
      Feedjira::Parser::ITunesRSS.parse(xml)
    else
      raise 'Feed type not supported'
      # Feedjira.parse(xml)
    end
  end

  def includes_itunes_tags?(start_of_doc)
    %r{xmlns:itunes\s?=\s?["']http://www\.itunes\.com/dtds/podcast-1\.0\.dtd["']}i =~ start_of_doc
  end
end
