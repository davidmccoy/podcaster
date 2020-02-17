# Promotes file from s3 cache directory to normal s3 directory
class UpdateDownloadCountWorker
  include Sidekiq::Worker

  PERMITTED_FEEDS = %w[individual aggregate_feed].freeze

  def perform(post_id, feed)
    @postable = Post.find_by_id(post_id).postable
    @feed = feed
    increment_downloads
    @postable.save
  end

  def increment_downloads
    increment_total_downloads
    increment_download_split
  end

  def increment_total_downloads
    @postable.increment(:total_downloads)
  end

  def increment_download_split
    return unless PERMITTED_FEEDS.include? @feed

    @postable.increment(:"#{@feed}_downloads")
  end
end
