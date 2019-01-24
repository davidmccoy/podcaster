# Defines audio-specific uploading logic
class AudioUploader < Shrine
  require 'streamio-ffmpeg'
  plugin :validation_helpers
  plugin :determine_mime_type
  plugin :add_metadata
  plugin :pretty_location
  plugin :remote_url, max_size: 100*1024*1024

  # Custom validations
  Attacher.validate do
    # validate_max_size 5*1024*1024, message: "is too large (max is 5 MB)"
    validate_mime_type_inclusion %w[audio/ogg audio/mpeg audio/wav], message: "must be an .mp3, .wav, or .ogg"
  end

  # Save content length in HH:MM:SS
  add_metadata :length do |io|
    length = 0
    file = FFMPEG::Movie.new(io.path)
    length = file.duration.round

    hours   = length / 3600
    minutes = length / 60 % 60
    seconds = length % 60

    if hours == length
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
