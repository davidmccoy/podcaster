class Logo < Image
  def url(size)
    # if file_attacher.stored? && file
    #   "https://#{ENV["IMAGES_S3_BUCKET"]}.s3.amazonaws.com/#{fetch_image_id(size)}"
    # elsif file_attacher.cached? && file
    #   "https://#{ENV["IMAGES_S3_BUCKET"]}.s3.amazonaws.com/cache/#{fetch_image_id(size)}"
    # end
    fetch_image_id
  end

  private

  def fetch_image_id(size)
    p file.is_a? ImageUploader::UploadedFile
    p file
    if file.is_a? ImageUploader::UploadedFile
      file.url
    else
      file&.dig(size)&.url
    end
  end
end
