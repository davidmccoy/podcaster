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
        unless podcast
          podcast = Page.find_by_name(convert_itunes_url_to_name(feed_params[:podcast]))
        end
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

  def convert_itunes_url_to_name(podcast_param)
    case podcast_param
    when 'games-with-garfield-and-the-three-donkeys-podcast'
      'Games with Garfield'
    when 'mtg-childs-view'
      'MTG Child\'s View'
    when 'pauper-cage-podcast'
      'Pauper\'s Cage'
    when 'superfriends'
      'Super Friends'
    when 'djinns-playground'
      'Djinn\'s Playground'
    when 'pgpfilmcast'
      'PGP Filmcast'
    when 'raiders-of-teferis-puzzlebox'
      'Raiders of Teferi\'s Puzzle Box'
    when 'mtgcast-special-purpose-reserved'
      'MTGCast Special'
    when 'johnny-timmy-spike'
      'Timmy Johnny Spike'
    when 'slam-dunklers'
      'The Slam Dunklers'
    when 'yawgmoths-soap-opera'
      'Yawgmoth\'s Soap Opera'
    when 'summon-elder-dragon-highlander'
      'Summon Elder Dragon'
    end
  end
end
