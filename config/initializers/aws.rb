Aws.config.update({
  region: 'us-east-1',
  credentials: Aws::Credentials.new(Figaro.env.s3_key, Figaro.env.s3_secret),
})

S3_PODCASTS = Aws::S3::Resource.new.bucket(Figaro.env.s3_bucket)
