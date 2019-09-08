class Image < Attachment
  include ImageUploader::Attachment.new(:file)

  def url
    if file_attacher.stored? && file
      "https://#{ENV["IMAGES_S3_BUCKET"]}.s3.amazonaws.com/#{file.id}"
    elsif file_attacher.cached? && file
      "https://#{ENV["IMAGES_S3_BUCKET"]}.s3.amazonaws.com/cache/#{file.id}"
    end
  end
end
