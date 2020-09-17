require 'down'

namespace :logos do
  desc 're-processes images uploaded before resizing was implemented'

  task reprocess: :environment do
    Logo.find_each do |logo|
      file = Down.download(logo.url(:original))
      logo.update(file: file)
    end
  end
end
