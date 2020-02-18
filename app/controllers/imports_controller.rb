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
       user_id: current_user.id
     )

    ImportFromRssWorker.perform_async(page.id, import_params[:url])

    redirect_to page_path(page)
  end

  private

  def import_params
    params.permit(:url)
  end
end
