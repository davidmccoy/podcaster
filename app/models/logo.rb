class Logo < Image
  def url(size)
    fetch_image_url(size)
  end

  private

  # accessig an image's url is different when first uploaded and after processing
  def fetch_image_url(size)
    if file_attacher.stored?
      file[size]&.url&.split('?')&.first
    else
      "https://#{ENV["AUDIO_S3_BUCKET"]}.s3.amazonaws.com/cache/#{file.id}"
    end
  end
end
