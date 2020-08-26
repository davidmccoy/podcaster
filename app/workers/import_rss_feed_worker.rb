# Generates jobs for importing episodes from an RSS feed
class ImportRssFeedWorker
  include Sidekiq::Worker

  # TODO: ideally we would verify the data that we're seeing
  def perform(page_id, url)
    page = Page.find(page_id)

    # fetch and parse the RSS feed
    xml = HTTParty.get(url).body
    feed = Feedjira.parse(xml)

    # enqueue worker to attach a logo
    ::ImportLogoWorker.perform_async(page.id, feed.image.url)

    # iterate over the entries and make posts/podcast episodes
    # perhaps we can limit the number of episodes for free users?
    # TODO: most of this is repeated from the check RSS feed worker
    feed.entries.each do |entry|
      # set up attributes
      post_params = {
        page_id: page.id,
        postable_type: 'PodcastEpisode',
        publish_time: entry.published,
        slug: "#{entry.title.parameterize}-#{SecureRandom.hex(5)}",
        postable_attributes: {
          title: entry.title,
          content: entry.summary,
          imported: true,
          guid: entry.entry_id,
        }
      }

      # assign attributes
      post = Post.new(post_params)
      post.save!

      # either override default Shrine behavior for externally-hosted files
      # or enqueue a worker to import audio to s3
      if page.externally_hosted
        Audio.new.tap do |a|
          a.attachable_type = 'PodcastEpisode'
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
end
