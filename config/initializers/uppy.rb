require "uppy/s3_multipart"

resource = Aws::S3::Resource.new(
  access_key_id:      ENV['S3_KEY'],
  secret_access_key:  ENV['S3_SECRET'],
  region:             ENV['S3_REGION']
)

bucket = resource.bucket(ENV['AUDIO_S3_BUCKET'])

UPPY_S3_MULTIPART_APP = Uppy::S3Multipart::App.new(bucket: bucket)
