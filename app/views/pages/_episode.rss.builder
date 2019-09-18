if syndicated
  guid = "https://www.mtgcast.com/podcasts/#{post.page.slug}/posts/#{post.slug}"
  title = "#{post.page.name}: #{post.postable.title}"
  link = "https://www.mtgcast.com/podcasts/#{post.page.slug}/posts/#{post.slug}"
  author = post.page.name
  if post.postable.podcast_episode
    s3_url = post.postable.audio.first.url
    url = page_post_audio_link_url(post.page.slug, post.slug, post.postable.podcast_episode.id, s3_url)
  else
    url = nil
  end
else
  guid = "https://www.mtgcast.com/podcasts/#{@page.slug}/posts/#{post.slug}"
  title = post.postable.title
  link = "https://www.mtgcast.com/podcasts/#{@page.slug}/posts/#{post.slug}"
  author = @page.name
  if post.postable.podcast_episode
    s3_url = post.postable.audio.first.url
    url = page_post_audio_link_url(@page.slug, post.slug, post.postable.podcast_episode.id, s3_url)
  else
    url = nil
  end
end

xml.item do
  xml.guid({:isPermaLink => "false"}, guid)
  xml.title title
  xml.pubDate post.publish_time.to_s(:rfc822)
  xml.link link
  xml.itunes :duration, post.postable.audio.first&.file&.metadata&.dig('length')
  xml.itunes :author, author
  xml.itunes :explicit, 'no'
  xml.itunes :summary, post.postable.description
  xml.itunes :subtitle, truncate(post.postable.description, :length => 150)
  xml.description post.postable.description
  xml.enclosure :url => url, :length => post.postable.audio.first&.file&.metadata&.dig('size'), :type => post.postable.audio.first&.file&.metadata&.dig('mime_type')
  xml.itunes :image, href: @image
end
