#
class PagesController < ApplicationController
  before_action :set_page

  def feed
    @image = ActionController::Base.helpers.asset_path('mtgcastlogoitunes.png', host: root_url)
    @date = @page.posts.first ?
      @page.posts.first.created_at.to_s(:rfc822) :
      DateTime.now.to_s(:rfc822)
    render template: 'pages/feed.rss.builder', layout: false
  end

  def mtgcast
    @image = ActionController::Base.helpers.asset_path('mtgcastlogoitunes.png', host: root_url)
    @episodes = PodcastEpisode.order(date: :desc).limit(100)
    @date = @episodes.first ?
      @episodes.first.created_at.to_s(:rfc822) :
      DateTime.now.to_s(:rfc822)
    render template: 'pages/mtgcast_feed.rss.builder', layout: false
  end
end
