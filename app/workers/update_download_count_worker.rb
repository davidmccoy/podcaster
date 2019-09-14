# Promotes file from s3 cache directory to normal s3 directory
class UpdateDownloadCountWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find_by_id(post_id)
    post.postable.increment!(:downloads)
  end
end
