# Deletes file from s3 cache
class DeleteFromS3Worker
  include Sidekiq::Worker

  def perform(data)
    # we can't delete externally-hosted files
    return if JSON.parse(data['attachment'])['storage'] == 'external'
    Shrine::Attacher.delete(data)
  end
end
