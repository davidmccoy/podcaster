class Audio < Attachment
  include AudioUploader::Attachment.new(:file)

  def url
    "https://#{ENV["S3_BUCKET"]}.s3.amazonaws.com/#{file.id}"
  end
end
