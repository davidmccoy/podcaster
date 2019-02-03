# Promotes file from s3 cache directory to normal s3 directory
class PromoteFromCacheWorker
  include Sidekiq::Worker

  def perform(data)
    Shrine::Attacher.promote(data)
  end
end
