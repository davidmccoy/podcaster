class Logo < Image
  def url(size)
    fetch_image_url(size)
  end

  private

  # accessig an image's url is different when first uploaded and after processing
  def fetch_image_url(size)
    if file.is_a? ImageUploader::UploadedFile
      file.url
    else
      file&.dig(size)&.url
    end
  end
end
