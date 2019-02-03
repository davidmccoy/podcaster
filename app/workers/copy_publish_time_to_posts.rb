# Copies date from PodcastEpisodes to their Posts' publish time
class CopyPublishTimeToPosts
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find(post_id)

    raise 'couldn\'t find podcast episode' unless post.postable

    post.update(publish_time: post.postable.date.to_datetime)
  end
end
