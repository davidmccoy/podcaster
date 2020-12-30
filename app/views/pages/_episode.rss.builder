xml.item do
  xml.guid({:isPermaLink => "false"}, episode.url)
  xml.title episode.formatted_title
  xml.pubDate episode.post.publish_time.to_s(:rfc822)
  xml.link episode.url
  xml.itunes :duration, episode.audio.first&.file&.metadata&.dig('length')
  xml.itunes :author, episode.page.name
  xml.itunes :explicit, 'no'
  xml.itunes :summary do
    (xml.cdata!(episode.content.to_s) unless episode.content == nil)
  end
  xml.itunes :subtitle, truncate(episode.content.to_plain_text, :length => 150)
  xml.description do
    (xml.cdata!(episode.content.to_s) unless episode.content == nil)
  end
  xml.enclosure :url => episode.media_url(syndicated),
    :length => episode.audio.first&.file&.metadata&.dig('size'),
    :type => episode.audio.first&.file&.metadata&.dig('mime_type')
  xml.itunes :image, href: @image
end
