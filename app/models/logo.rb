class Logo < Image
  def url(size)
    image = fetch_image(size)

    if image
      image.url
    else
      file.dig(:origina).url
    end
  end

  private

  def fetch_image(size)
    file.dig(size)
  end
end