# Defines audio-specific uploading logic
class AudioUploader < Shrine
  require 'ffprober'
  plugin :validation_helpers
  plugin :determine_mime_type, analyzer: :marcel
  plugin :add_metadata
  plugin :restore_cached_data
  plugin :processing
  plugin :refresh_metadata
  plugin :pretty_location
  plugin :remote_url, max_size: 1000*1024*1024

  # Custom validations
  Attacher.validate do
    # validate_max_size 5*1024*1024, message: "is too large (max is 5 MB)"
    validate_mime_type_inclusion %w[audio/ogg audio/mpeg audio/wav audio/x-wav audio/aac audio/aacp audio/mp4], message: 'must be an .mp3, .wav, .aac, .m4a, or .ogg'
  end

  process(:store) do |io, context|
    io.refresh_metadata!(context)
    io
  end

  # Save content length in HH:MM:SS
  add_metadata :length do |io, context|
    next unless context[:action] == :store
    p 'finding length'
    length = 0
    file = nil
    if io.class == AudioUploader::UploadedFile
      file = Ffprober::Parser.from_file(io.download.path)
    else
      file = Ffprober::Parser.from_file(io.download)
    end
    length = file.json[:streams][0][:duration].to_i

    hours   = length / 3600
    minutes = length / 60 % 60
    seconds = length % 60

    if hours.zero?
      format('%d:%02d', minutes, seconds)
    else
      format('%d:%02d:%02d', hours, minutes, seconds)
    end
  end

  # Generate a custom s3 key
  def generate_location(io, context = {})
    extension   = ".#{io.extension}" if io.is_a?(UploadedFile) && io.extension
    extension ||= File.extname(extract_filename(io).to_s).downcase
    filename = context[:metadata]['filename'].split('.')[0].parameterize

    "#{SecureRandom.hex(5)}-#{filename}#{extension}"
  end
end
