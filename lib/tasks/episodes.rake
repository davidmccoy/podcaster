namespace :episodes do
  desc 'Takes a CSV of episode titles, file urls, and stats and adds them to the database'

  task import_from_csv: :environment do
    EpisodeCsvReaderWorker.perform_async
  end
end
