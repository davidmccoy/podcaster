# redirects old feed urls from the previous application to their new locations
class OldFeedsController < ApplicationController
  def redirect
    podast = nil
    # Active Podcasts aggregate feed
    # '/feed?cat=4'
    # if request.path == '/feed' && feed_params[:cat] == '4'
    if feed_params[:podcast]
      podcast = Page.find_by_slug(feed_params[:podcast])
      unless podcast
        podcast_name = feed_params[:podcast].gsub('-', ' ')
        podcast = Page.where('lower(name) = ?', podcast_name).first
      end
    end

    if podcast
      redirect_to page_feed_path(podcast) and return
    else
      redirect_to root_path and return
    end
  end

  private

  def feed_params
    params.permit(:cat, :podcast)
  end
end
