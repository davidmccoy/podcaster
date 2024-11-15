# Defines audio-specific uploading logic
class AudioUploader < Shrine
  require 'ffprober'
  plugin :validation_helpers
  plugin :determine_mime_type, analyzer: :marcel
  plugin :add_metadata
  plugin :restore_cached_data
  plugin :pretty_location
  plugin :remote_url, max_size: 1000*1024*1024

  # Custom validations
  Attacher.validate do
    # validate_max_size 5*1024*1024, message: "is too large (max is 5 MB)"
    validate_mime_type_inclusion %w[audio/ogg audio/mpeg audio/wav audio/x-wav audio/aac audio/aacp audio/mp4], message: 'must be an .mp3, .wav, .aac, .m4a, or .ogg'
  end

  add_metadata do |io|
    length = 0
    bitrate = 0
    file = nil

    if io.class == AudioUploader::UploadedFile
      file = Ffprober::Parser.from_file(io.download.path)
    else
      file = Ffprober::Parser.from_file(io.download)
    end

    p 'finding length'
    length = file.json[:streams][0][:duration].to_i

    hours   = length / 3600
    minutes = length / 60 % 60
    seconds = length % 60

    formatted_length = if hours.zero?
      format('%d:%02d', minutes, seconds)
    else
      format('%d:%02d:%02d', hours, minutes, seconds)
    end

    p 'finding bit rate'
    bitrate = file.json[:streams][0][:bit_rate].to_i

    {
      "length" => formatted_length,
      "bitrate" => bitrate,
    }
  end

  # # Save content length in HH:MM:SS
  # add_metadata :length do |io|
  #   # next unless context[:action] == :store
  #   p 'finding length'
  #   length = 0
  #   file = nil
  #   if io.class == AudioUploader::UploadedFile
  #     file = Ffprober::Parser.from_file(io.download.path)
  #   else
  #     file = Ffprober::Parser.from_file(io.download)
  #   end
  #   length = file.json[:streams][0][:duration].to_i

  #   hours   = length / 3600
  #   minutes = length / 60 % 60
  #   seconds = length % 60

  #   if hours.zero?
  #     format('%d:%02d', minutes, seconds)
  #   else
  #     format('%d:%02d:%02d', hours, minutes, seconds)
  #   end
  # end

  # add_metadata :bit_rate do |io|
  #   # next unless context[:action] == :store
  #   p 'finding bit rate'
  #   if io.class == AudioUploader::UploadedFile
  #     file = Ffprober::Parser.from_file(io.download.path)
  #   else
  #     file = Ffprober::Parser.from_file(io.download)
  #   end

  #   file.json[:streams][0][:bit_rate].to_i
  # end


  # Generate a custom s3 key
  def generate_location(io, context = {})
    extension   = ".#{io.extension}" if io.is_a?(UploadedFile) && io.extension
    extension ||= File.extname(extract_filename(io).to_s).downcase
    filename = context[:metadata]['filename'].split('.')[0].parameterize

    "#{SecureRandom.hex(5)}-#{filename}#{extension}"
  end
end
