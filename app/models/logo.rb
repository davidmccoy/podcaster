class Logo < Image
  def url(size)
    if file_attacher.stored? && file
      "https://#{ENV["IMAGES_S3_BUCKET"]}.s3.amazonaws.com/#{fetch_image(size).id}"
    elsif file_attacher.cached? && file
      "https://#{ENV["IMAGES_S3_BUCKET"]}.s3.amazonaws.com/cache/#{fetch_image(size).id}"
    end
  end

  private

  def fetch_image(size)
    file&.dig(size)
  end
end