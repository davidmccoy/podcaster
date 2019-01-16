# encoding: UTF-8

xml.instruct! :xml, :version => "1.0"

xml.rss :version => "2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.tag!("atom:link",  "href": "#{page_feed_url(@page)}", "rel": "self", "type": "application/rss+xml")
    # TODO: for pagination:
    # <atom:link href="http://feeds.soundcloud.com/users/soundcloud:users:299862962/sounds.rss?before=316446903" rel="next" type="application/rss+xml"/>
    xml.title @page.name
    xml.link page_feed_url(@page)
    xml.pubDate @page.posts.first.created_at.to_s(:rfc822)
    xml.lastBuildDate @page.posts.first.created_at.to_s(:rfc822)
    # time to live. It's a number of minutes that indicates how long a channel can be cached before refreshing from the source
    # <ttl>60</ttl>
    xml.language 'en'
    xml.copyright 'All rights reserved, Authorization Code 000689'
    xml.webMaster 'admin@mtgcast.fm'
    xml.description @page.name
    xml.itunes :subtitle, "#{@page.name} is provided by MTGCast."
    xml.itunes :owner do
      xml.itunes :name, @page.name
      xml.itunes :email, 'admin@mtgcast.fm'
    end
    xml.itunes :author, @page.name
    xml.itunes :explicit, 'no'
    xml.itunes :image, href: @image
    xml.image do
      xml.url @image
      xml.title @page.name
      xml.link "https://www.mtgcast.com/podcasts/#{@page.slug}"
    end
    xml.itunes :category, text: 'Games & Hobbies'
    # For subcategories
    # xml.itunes :category, :text => 'Technology' do
    #   xml.itunes :category, :text => 'Software How-To'
    # end
    # xml.itunes :category, :text => 'Education' do
    #   xml.itunes :category, :text => 'Training'
    # end
     # Block from iTunes? (should only be used on items)
    # xml.itunes :block, 'no'

    @page.posts.each do  |post|
      xml.item do
        xml.guid({:isPermaLink => "false"}, "https://www.mtgcast.com/podcasts/#{@page.slug}/post/#{post.id}")
        xml.title post.postable.title
        xml.pubDate post.postable.date.to_s(:rfc822)
        xml.link "https://www.mtgcast.com/podcasts/#{@page.slug}/post/#{post.id}"
        xml.itunes :duration, '01:53:52'
        xml.itunes :author, @page.name
        xml.itunes :explicit, 'no'
        xml.itunes :summary, post.postable.description
        xml.itunes :subtitle, truncate(post.postable.description, :length => 150)
        xml.description post.postable.description
        xml.enclosure :url => post.postable.external_file_url, :length => 42986611, :type => 'audio/mpeg'
        xml.itunes :image, href: @image
      end
    end
  end
end
