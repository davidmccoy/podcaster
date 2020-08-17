# Generates jobs for importing episodes from an RSS feed
class ImportLogoWorker
  include Sidekiq::Worker

  # TODO: ideally we would verify the data that we're seeing
  def perform(page_id, url)
    page = Page.find(page_id)
    logo = page.build_logo(
      file: open(url),
      attachable_type: 'Page',
      attachable_id: page.id,
      label: 'logo'
    )
    logo.save!
  end
end
