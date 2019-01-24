require "shrine"
require "shrine/storage/s3"

s3_options = {
    access_key_id:      ENV['S3_KEY'],
    secret_access_key:  ENV['S3_SECRET'],
    region:             ENV['S3_REGION'],
    bucket:             ENV['S3_BUCKET'],
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
  store: Shrine::Storage::S3.new(**s3_options),
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :logging, logger: Rails.logger

# for multiple buckets
# https://github.com/shrinerb/shrine/issues/26
# Shrine.storages[:custom_cache] = ...
# Shrine.storages[:custom_store] = ...
# class MyUploader < Shrine
#   plugin :default_storage, cache: :custom_cache, :store: :custom_store
# end
