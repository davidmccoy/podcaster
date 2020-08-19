# encoding: UTF-8

xml.instruct! :xml, :version => "1.0"

xml.rss :version => "2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.tag!("atom:link",  "href": "#{feed_url}", "rel": "self", "type": "application/rss+xml")
    # TODO: for pagination:
    # <atom:link href="http://feeds.soundcloud.com/users/soundcloud:users:299862962/sounds.rss?before=316446903" rel="next" type="application/rss+xml"/>
    xml.title 'MTGCast'
    xml.link 'https://www.mtgcast.com'
    xml.pubDate @date
    xml.lastBuildDate @date
    # time to live. It's a number of minutes that indicates how long a channel can be cached before refreshing from the source
    # <ttl>60</ttl>
    xml.language 'en'
    xml.copyright 'All rights reserved.'
    xml.webMaster 'admin@mtgcast.fm'
    xml.description 'MTGCast'
    xml.itunes :subtitle, "The full MTGCast feed."
    xml.itunes :owner do
      xml.itunes :name, 'MTGCast'
      xml.itunes :email, 'admin@mtgcast.fm'
    end
    xml.itunes :author, 'MTGCast'
    xml.itunes :explicit, 'no'
    xml.itunes :image, href: @image
    xml.image do
      xml.url @image
      xml.title 'MTGCast'
      xml.link "https://www.mtgcast.com/podcasts/"
    end
    xml.itunes :category, text: 'Leisure' do
      xml.itunes :category, text: 'Games'
    end
    # For subcategories
    # xml.itunes :category, :text => 'Technology' do
    #   xml.itunes :category, :text => 'Software How-To'
    # end
    # xml.itunes :category, :text => 'Education' do
    #   xml.itunes :category, :text => 'Training'
    # end
     # Block from iTunes? (should only be used on items)
    # xml.itunes :block, 'no'

    xml << render(
      partial: 'episode',
      collection: @posts.map { |post| PodcastEpisodeDecorator.new(post) },
      as: :post,
      locals: {
        syndicated: true
      },
      cached: true
    ) unless @posts.none?
  end
end
