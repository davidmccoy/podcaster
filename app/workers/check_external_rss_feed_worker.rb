# Check an external RSS feeds for new episodes
class CheckExternalRssFeedWorker
  include Sidekiq::Worker

  def perform(page_id)
    page = Page.includes(posts: :postable).find(page_id)

    # fetch and parse the RSS feed
    xml = HTTParty.get(page.external_rss).body
    feed = Feedjira.parse(xml)

    # find all unique identifiers in the feed
    rss_guids = feed.entries.map { |entry| entry.entry_id }

    # find all guids of episodes in the database
    post_guids = page.posts.map { |post| post.postable.guid }

    # find the guids that exist on the RSS feed but not in the database
    new_guids = rss_guids - post_guids

    # find new episodes on the RSS feed based on guid
    new_entries = feed.entries.select { |entry| new_guids.include? entry.entry_id }

    # add new episodes to the database
    # TODO: this is all repeated from the import RSS feed worker
    new_entries.each do |entry|
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

      # attach an audio record to the post
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
    end

    # we want to soft delete episodes that fall off of RSS feeds, either because
    # they were deleted or because the host limits the number of episodes on a
    # feed.
    # find the guids that exist in the database but not on the RSS feed
    # missing_guids = post_guids - rss_guids

    # # find the episodes in the database to soft delete by guid
    # missing_posts = page.posts.select { |post| missing_entries.include? post.postable.guid }

    # # soft delete all missing episodes
    # missing_posts.soft_delete_all
  end
end
