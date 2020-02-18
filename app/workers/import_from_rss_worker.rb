# Generates jobs for importing episodes from an RSS feed
class ImportFromRssWorker
  include Sidekiq::Worker

  # TODO: ideally we would verify the data that we're seeing
  def perform(page_id, url)
    page = Page.find(page_id)

    # fetch and parse the RSS feed
    xml = HTTParty.get(url).body
    feed = Feedjira.parse(xml)

    # iterate over the entries and make posts/podcast episodes
    feed.entries.take(2).each do |episode|
      # set up attributes
      post_params = {
        page_id: page.id,
        postable_type: 'PodcastEpisode',
        publish_time: episode.published,
        slug: "#{episode.title.parameterize}-#{SecureRandom.hex(5)}",
        postable_attributes: {
          title: episode.title,
          content: episode.summary,
        }
      }

      # assign attributes
      post = Post.new(post_params)

      Post.transaction do
        # create audio
        if post.save
          audio = Audio.new.tap do |a|
            a.attachable_type = post.postable.class
            a.attachable_id = post.postable.id
            a.label = 'podcast_episode'
            a.file = open(episode.enclosure_url)
            a.save
          end
        end
      end
    end
  end
end
