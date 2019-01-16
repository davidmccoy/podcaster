# converts temp Episodes into full PodcastEpisodes with Posts and Pages
class EpisodeConverterWorker
  include Sidekiq::Worker

  def perform(episode_id)
    episode = Episode.find_by_id(episode_id)

    podcast = Page.where('name ilike ?', episode.artist).first_or_create(name: episode.artist)

    PodcastEpisode.transaction do
      Post.transaction do
        title = episode.title.nil? ? episode.blubrry_filename : episode.title
        podcast_episode = PodcastEpisode.create!(
          title: title,
          description: episode.description,
          filename: episode.blubrry_filename,
          external_file_url: episode.blubrry_file_url,
          external_date: episode.blubrry_date,
          external_unique_downloads: episode.blubrry_unique_downloads,
          external_total_downloads: episode.blubrry_total_downloads,
          date: episode.date
        )

        post = podcast_episode.create_post!(page_id: podcast.id)
      end
    end

    episode.update(file_migrated: true)
  end
end
