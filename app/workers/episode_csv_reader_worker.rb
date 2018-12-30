class EpisodeCsvReaderWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(*args)
    file = CSV.read(Rails.root.join('app/assets/files/mtgcastdotcom.csv'))

    file.each do |row|
      Episode.where(
        blubrry_filename: row[0],
        blubrry_file_url: row[1],
        blubrry_unique_downloads: row[2],
        blubrry_total_downloads: row[3]
      ).first_or_create
    end
  end
end
