# Deletes file from s3 cache
class DeleteFromS3Worker
  include Sidekiq::Worker

  def perform(data)
    Shrine::Attacher.delete(data)
  end
end
