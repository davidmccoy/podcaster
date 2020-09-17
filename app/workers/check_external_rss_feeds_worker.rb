# Loop through pages with external RSS feeds and generate workers to check for
# new episodes
require 'sidekiq-scheduler'

class CheckExternalRssFeedsWorker
  include Sidekiq::Worker

  def perform
    externally_hosted_pages.find_each do |page|
      ::CheckExternalRssFeedWorker.perform_async(page.id)
    end
  end

  private

  def externally_hosted_pages
    Page.where(externally_hosted: true)
  end
end
