class LibsynEpisodeCsvReaderWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(*args)
    file = CSV.read(Rails.root.join('app/assets/files/libsynfiles.csv'))

    file.each do |row|
      p row[1]
      Episode.where(
        artist: row[0],
        title: row[1],
        description: row[2],
        blubrry_file_url: row[3],
        date: row[4].to_time
      ).first_or_create
    end
  end
end
