class PodcastEpisodeDecorator < BaseDecorator
  delegate :helpers, to: ApplicationController

  def title
    "#{page.name}: #{postable.title}"
  end

  def url
    url_helpers.page_post_url(page.slug, slug)
  end

  def file_extension
    postable.audio.first.url.split('.')[-1]
  end

  def base_url
    url_helpers.page_post_audio_url(page.slug, slug, postable.podcast_episode.id)
  end

  def media_url(syndicated)
    # return unless postable.podcast_episode
    "#{base_url}.#{file_extension}?#{source(syndicated)}"
  end

  private

  def source(syndicated)
    if syndicated
      "source=aggregate_feed"
    else
      "source=individual"
    end
  end
end
