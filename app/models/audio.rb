class Audio < Attachment
  include AudioUploader::Attachment.new(:file)

  def url
    # for externally-hosted files, we store the full url in the id attribute
    if !file.storage
      file.id
    elsif file_attacher.stored? && file
      "https://#{ENV["AUDIO_S3_BUCKET"]}.s3.amazonaws.com/#{file.id}"
    elsif file_attacher.cached? && file
      "https://#{ENV["AUDIO_S3_BUCKET"]}.s3.amazonaws.com/cache/#{file.id}"
    end
  end
end
