# extracts device and location data and updates cached play counts
# how many transactions are in this worker?
class ProcessDownloadWorker
  include Sidekiq::Worker

  PERMITTED_SOURCES = %w[individual aggregate_feed].freeze

  def perform(download_id)
    @download = Download.includes(:audio_post).find(download_id)
    @podcast_episode = @download.audio_post
    @source = @download.feed_source

    process_analytics
    increment_downloads
    # is this necessary? i believe `.increment` is its own SQL command
    @podcast_episode.save
  end

  private

  def process_analytics
    user_agent = @download.user_agent
    client = DeviceDetector.new(user_agent)

    # external API call
    location = Geocoder.search(@download.ip).first

    @download.update(
      browser: client.name,
      os: client.os_name,
      device_type: client.device_type,
      country: location.country,
      region: location.region,
      city: location.city,
      latitude: location.latitude,
      longitude: location.longitude,
      source_feed: ensure_source_feed,
    )
  end

  def ensure_source_feed
    @download.source_feed || @download.params['blob_id']&.split('?')[1]&.split('=')[1]
  end

  def increment_downloads
    increment_total_downloads
    increment_download_split
  end

  def increment_total_downloads
    @podcast_episode.increment(:total_downloads)
  end

  def increment_download_split
    return unless PERMITTED_SOURCES.include? @source

    @podcast_episode.increment(:"#{@source}_downloads")
  end
end
