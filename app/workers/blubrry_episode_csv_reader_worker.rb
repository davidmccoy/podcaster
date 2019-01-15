class BlubrryEpisodeCsvReaderWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(*args)
    file = CSV.read(Rails.root.join('app/assets/files/blubrryfiles.csv'))

    file.each do |row|
      Episode.where(
        blubrry_filename: row[0],
        blubrry_file_url: row[1],
        blubrry_date: row[2],
        date: Date.strptime(row[2], '%m/%d/%Y')
      ).first_or_create
    end
  end
end
