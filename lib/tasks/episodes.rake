namespace :episodes do
  desc 'Takes a CSV of episode titles, file urls, and stats and adds them to the database'

  task import_from_blubrry_csv: :environment do
    BlubrryEpisodeCsvReaderWorker.perform_async
  end

  task import_from_libsyn_csv: :environment do
    LibsynEpisodeCsvReaderWorker.perform_async
  end

  desc 'Reads mp3 files id3 tags to populate title and artist fields'

  task get_titles_and_artists: :environment do
    Episode.where(title: nil).find_each do |episode|
      EpisodeTagReaderWorker.perform_async(episode.id)
    end
  end
end
