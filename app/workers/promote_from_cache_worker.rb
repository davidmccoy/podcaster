# Promotes file from s3 cache directory to normal s3 directory
class PromoteFromCacheWorker
  include Sidekiq::Worker

  def perform(data)
    Shrine::Attacher.promote(data)
  end

  # {
  #   "attachment"=> # audio.file.data.to_s
  #     "{\"id\":\"a523f01461c0a6595780a8fdcba74d0b.mp3\",\"storage\":\"cache\",\"metadata\":{\"size\":26841888,\"filename\":\"Leaving a Legacy - Ep 301 - Too Hot to Title.mp3\",\"mime_type\":\"audio/mpeg\",\"length\":null}}",
  #  "record"=>["Audio", "10594"],
  #  "name"=>"file",
  #  "shrine_class"=>"AudioUploader",
  #  "action"=>"store",
  #  "phase"=>"store"
  # }

  # {
  #   "attachment"=>
  #    "{\"id\"=>\"729844f2d9-open-uri20200817-4-1hpawjx\", \"storage\"=>\"cache\", \"metadata\"=>{\"filename\"=>\"open-uri20200817-4-1hpawjx\", \"size\"=>63847780, \"mime_type\"=>\"audio/mpeg\", \"length\"=>nil}}",
  #  "record"=>["Audio", "10177"],
  #  "name"=>"file",
  #  "shrine_class"=>"AudioUploader",
  #  "action"=>"store",
  #  "phase"=>"store"
  # }

  # '{"id"=>"729844f2d9-open-uri20200817-4-1hpawjx", "storage"=>"cache", "metadata"=>{"filename"=>"open-uri20200817-4-1hpawjx", "size"=>63847780, "mime_type"=>"audio/mpeg", "length"=>null}}'








  # def promote(uploaded_file = get, **options)
  #   stored_file = store!(uploaded_file, **options)
  #   result = swap(stored_file) or _delete(stored_file, action: :abort)
  #   result
  # end

  # # Uploads the file using the #store uploader, passing the #context.
  # def store!(io, **options)
  #   Shrine.deprecation("Sending :phase to Attacher#store! is deprecated and will not be supported in Shrine 3. Use :action instead.") if options[:phase]

  #   # store = Shrine.new(:store)
  #   store.upload(io, context.merge(_equalize_phase_and_action(options)))
  # end

  # # Temporary method used for transitioning from :phase to :action.
  # def _equalize_phase_and_action(options)
  #   options[:phase]  = options[:action] if options.key?(:action)
  #   options[:action] = options[:phase] if options.key?(:phase)
  #   options
  # end

  # # Calls #update, overriden in ORM plugins, and returns true if the
  # # attachment was successfully updated.
  # def swap(uploaded_file)
  #   update(uploaded_file)
  #   uploaded_file if uploaded_file == get
  # end
end
