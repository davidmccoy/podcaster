# redirects old feed urls from the previous application to their new locations
class OldFeedsController < ApplicationController
  def redirect
    # Active Podcasts aggregate feed
    # '/feed?cat=4'
    if request.path == '/feed' && feed_params[:cat] == '4'
      # redirect_to active podcasts feed and return
    elsif feed_params[:podcast]
      podcast_name = feed_params[:podcast].gsub('-', ' ')
      # podcast = Page.where('lower(name) = ?', podcast_name).first
      # redirect_to podcast feed and return
    end
  end

  private

  def feed_params
    params.permit(:cat, :podcast)
  end
end
