# Defines image-specific uploading logic
require 'image_processing/mini_magick'

class ImageUploader < Shrine
  plugin :default_storage, cache: :cache, store: :image_store
  plugin :derivatives
  plugin :validation_helpers
  plugin :determine_mime_type
  plugin :add_metadata
  plugin :restore_cached_data
  plugin :pretty_location
  plugin :remote_url, max_size: 10*1024*1024

  # Custom validations
  Attacher.validate do
    validate_max_size 10*1024*1024, message: 'is too large (max is 10 MB)'
    validate_mime_type_inclusion %w[image/jpeg image/jpeg image/png image/gif], message: 'must be a .jpg, .png, or .gif'
  end

  # process multiple versions of an uploaded image
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      large:  magick.resize_to_fill!(1400, 1400),
      medium: magick.resize_to_fill!(700, 700),
      small:  magick.resize_to_fill!(300, 300),
    }
  end

  # Generate a custom s3 key
  def generate_location(io, record: nil, name: nil, derivative: nil, **)
    # extension   = ".#{io.extension}" if io.is_a?(UploadedFile) && io.extension
    # extension ||= File.extname(extract_filename(io).to_s).downcase
    # filename =
    #   # for original files passed to shrine in the normal creation process
    #   if io.try(:data)
    #     context[:metadata]['filename'].split('.')[0].parameterize
    #   else
    #     if record.try(:file)
    #       if context[:record].file[:original]
    #         # for changing the attached file via and update method
    #         # context[:record].file[:original].metadata['filename'].split('.')[0].parameterize
    #         record.file(:original).metadata["filename"].split('.')[0].parameterize
    #       else
    #         # for the processed versions generated during normal shrine processing
    #         # context[:record].file.metadata['filename'].split('.')[0].parameterize
    #         record.file.metadata["filename"].split('.')[0].parameterize
    #       end
    #     else
    #       # for manually ading a file when creating a record
    #       # context[:metadata]['filename'].split('.')[0].parameterize
    #       binding.remote_pry
    #     end
    #   end

    name = super
    prefix, suffix = name.split(record.id.to_s)
    encoded_id = Base64.urlsafe_encode64(record.id.to_s)

    prefix + encoded_id + suffix
  end
end
