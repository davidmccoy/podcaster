xml.item do
  xml.guid({:isPermaLink => "false"}, post.url)
  xml.title post.title
  xml.pubDate post.publish_time.to_s(:rfc822)
  xml.link post.url
  xml.itunes :duration, post.postable.audio.first&.file&.metadata&.dig('length')
  xml.itunes :author, post.page.name
  xml.itunes :explicit, 'no'
  xml.itunes :summary do
    (xml.cdata!(post.postable.content.to_s) unless post.postable.content == nil)
  end
  xml.itunes :subtitle, truncate(post.postable.content.to_plain_text, :length => 150)
  xml.description do
    (xml.cdata!(post.postable.content.to_s) unless post.postable.content == nil)
  end
  xml.enclosure :url => post.media_url(syndicated),
    :length => post.postable.audio.first&.file&.metadata&.dig('size'),
    :type => post.postable.audio.first&.file&.metadata&.dig('mime_type')
  xml.itunes :image, href: @image
end
