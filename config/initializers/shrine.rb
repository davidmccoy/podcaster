require "shrine"
require "shrine/storage/s3"

# === audio options
audio_s3_options = {
  access_key_id:      ENV['S3_KEY'],
  secret_access_key:  ENV['S3_SECRET'],
  region:             ENV['S3_REGION'],
  bucket:             ENV['AUDIO_S3_BUCKET']
}

# === image options
image_s3_options = {
  access_key_id:      ENV['S3_KEY'],
  secret_access_key:  ENV['S3_SECRET'],
  region:             ENV['S3_REGION'],
  bucket:             ENV['IMAGES_S3_BUCKET']
}

# === external options
external_options = {
  access_key_id:      "nil",
  secret_access_key:  "nil",
  region:             "nil",
  bucket:             "nil",
}

# === shrine's storage options
# shrine expects settings with the name of cache and store so the audio uploader
# uses those names for now.
# images uses the default cache because uppy only supports one presigned endpoint
Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: 'cache', **audio_s3_options),
  store: Shrine::Storage::S3.new(**audio_s3_options),
  image_store: Shrine::Storage::S3.new(**image_s3_options),
  external: Shrine::Storage::S3.new(**external_options),
}

Shrine.logger = Rails.logger

# === shrine plugins
Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :instrumentation
Shrine.plugin :uppy_s3_multipart
Shrine.plugin :backgrounding
Shrine.plugin :derivatives,
  create_on_promote: true,
  versions_compatibility: true  # handle old column format, remove after migrating

# makes all uploaders use background jobs
Shrine::Attacher.promote_block do
  PromoteFromCacheWorker.perform_async(self.class.name, record.class.name, record.id, name.to_s, file_data)
end

Shrine::Attacher.destroy_block do
  DeleteFromS3Worker.perform_async(self.class.name, data)
end
