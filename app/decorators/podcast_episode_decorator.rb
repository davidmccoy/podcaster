class PodcastEpisodeDecorator < BaseDecorator
  delegate :helpers, to: ApplicationController

  def formatted_title
    "#{page.name}: #{title}"
  end

  def url
    url_helpers.page_post_url(page.slug, post.slug)
  end

  def file_extension
    audio.first.url.split('.')[-1]
  end

  def base_url
    url_helpers.page_post_audio_url(page.slug, post.slug, podcast_episode.id)
  end

  def media_url(syndicated)
    # return unless podcast_episode
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
