if syndicated
  guid = "https://www.mtgcast.com/podcasts/#{post.page.slug}/posts/#{post.slug}"
  title = "#{post.page.name}: #{post.postable.title}"
  link = "https://www.mtgcast.com/podcasts/#{post.page.slug}/posts/#{post.slug}"
  author = post.page.name
else
  guid = "https://www.mtgcast.com/podcasts/#{@page.slug}/posts/#{post.slug}"
  title = post.postable.title
  link = "https://www.mtgcast.com/podcasts/#{@page.slug}/posts/#{post.slug}"
  author = @page.name
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
  xml.enclosure :url => post.postable.audio&.first&.url, :length => post.postable.audio.first&.file&.metadata&.dig('size'), :type => post.postable.audio.first&.file&.metadata&.dig('mime_type')
  xml.itunes :image, href: @image
end
