#
class ImportsController < ApplicationController
  def new; end

  # TODO: we're fetching the RSS feed twice here, once in the action
  # once in the worker
  def create
    # fetch and parse the RSS feed
    xml = HTTParty.get(import_params[:url]).body
    feed = Feedjira.parse(xml)

    # create a page
    page = Page.create(
      name: feed.title,
      description: feed.description,
      user_id: current_user.id,
      externally_hosted: import_params[:externally_hosted],
      external_rss: import_params[:url],
    )

    ImportRssFeedWorker.perform_async(page.id, import_params[:url])

    flash[:notice] = 'Your episodes and logo are being imported. This process may take a few minutes, depending on the length of your RSS feed.'

    redirect_to page_path(page)
  end

  private

  def import_params
    params.permit(:externally_hosted, :url)
  end
end
