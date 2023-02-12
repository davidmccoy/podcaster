# Deletes file from s3 cache
class DeleteFromS3Worker
  include Sidekiq::Worker

  def perform(attacher_class, data)
    # we can't delete externally-hosted files
    return if data["storage"] == 'external'

    attacher_class = Object.const_get(attacher_class)

    attacher = attacher_class.from_data(data)
    attacher.destroy
  end
end
