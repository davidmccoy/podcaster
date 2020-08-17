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
    feed.entries.each do |episode|
      # set up attributes
      post_params = {
        page_id: page.id,
        postable_type: 'PodcastEpisode',
        publish_time: episode.published,
        slug: "#{episode.title.parameterize}-#{SecureRandom.hex(5)}",
        postable_attributes: {
          title: episode.title,
          content: episode.summary,
          imported: true,
        }
      }

      # assign attributes
      post = Post.new(post_params)
      post.save!

      # enqueue worker to import audio
      ::ImportAudioWorker.perform_async(post.postable_id, episode.enclosure_url)
    end
  end
end
