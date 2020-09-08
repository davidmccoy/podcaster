class Logo < Image
  def url(size)
    fetch_image_url(size)
  end

  private

  # accessig an image's url is different when first uploaded and after processing
  def fetch_image_url(size)
    if file.is_a? ImageUploader::UploadedFile
      # remove the auth headers
      file[size]&.url&.split('?')&.first
    else
      file&.dig(size)&.url&.split('?')&.first
    end
  end
end
