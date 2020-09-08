# Defines image-specific uploading logic
require 'image_processing/mini_magick'

class ImageUploader < Shrine
  plugin :default_storage, cache: :cache, store: :image_store
  plugin :validation_helpers
  plugin :determine_mime_type
  plugin :add_metadata
  plugin :restore_cached_data
  plugin :processing
  plugin :versions
  plugin :delete_raw
  plugin :pretty_location
  plugin :remote_url, max_size: 10*1024*1024

  # Custom validations
  Attacher.validate do
    validate_max_size 10*1024*1024, message: 'is too large (max is 10 MB)'
    validate_mime_type_inclusion %w[image/jpeg image/pjpeg image/png image/gif], message: 'must be a .jpg, .png, or .gif'
  end

  # process multiple versions of an uploaded image
  process(:store) do |io, context|
    # retain the original image
    versions = { original: io }

    # download the uploaded file from the temporary storage
    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)

      versions[:large]  = pipeline.resize_to_fill!(1400, 1400)
      versions[:medium] = pipeline.resize_to_fill!(700, 700)
      versions[:small]  = pipeline.resize_to_fill!(300, 300)
    end

    versions # return the hash of processed files
  end

  # Generate a custom s3 key
  def generate_location(io, context = {})
    extension   = ".#{io.extension}" if io.is_a?(UploadedFile) && io.extension
    extension ||= File.extname(extract_filename(io).to_s).downcase
    filename =
      if io.try(:data)
        context[:metadata]['filename'].split('.')[0].parameterize
      else
        if context[:record].try(:file)
          if context[:record].file[:original]
            context[:record].file[:original].metadata['filename'].split('.')[0].parameterize
          else
            context[:record].file.metadata['filename'].split('.')[0].parameterize
          end
        else
          context[:metadata]['filename'].split('.')[0].parameterize
        end
      end

    "#{SecureRandom.hex(5)}-#{filename}#{extension}"
  end
end
