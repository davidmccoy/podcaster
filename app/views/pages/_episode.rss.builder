guid = "https://www.mtgcast.com/podcasts/#{post.page.slug}/posts/#{post.slug}"
title = "#{post.page.name}: #{post.postable.title}"
link = "https://www.mtgcast.com/podcasts/#{post.page.slug}/posts/#{post.slug}"
author = post.page.name
file_extension = post.postable.audio.first.url.split('.')[-1]
base_url = page_post_audio_url(post.page.slug, post.slug, post.postable.podcast_episode.id)

if post.postable.podcast_episode
  if syndicated
    url = "#{base_url}.#{file_extension}?source=aggregate_feed"
  else
    url = "#{base_url}.#{file_extension}?source=individual"
  end
else
  url = nil
end

xml.item do
  xml.guid({:isPermaLink => "false"}, guid)
  xml.title title
  xml.pubDate post.publish_time.to_s(:rfc822)
  xml.link link
  xml.itunes :duration, post.postable.audio.first&.file&.metadata&.dig('length')
  xml.itunes :author, author
  xml.itunes :explicit, 'no'
  xml.itunes :summary do
    (xml.cdata!(post.postable.content.to_s) unless post.postable.content == nil)
  end
  xml.itunes :subtitle, truncate(post.postable.content.to_plain_text, :length => 150)
  xml.description do
    (xml.cdata!(post.postable.content.to_s) unless post.postable.content == nil)
  end
  xml.enclosure :url => url, :length => post.postable.audio.first&.file&.metadata&.dig('size'), :type => post.postable.audio.first&.file&.metadata&.dig('mime_type')
  xml.itunes :image, href: @image
end
