# Public posts controller, accessible to all users.
class TextPostsController < ApplicationController
  before_action :set_page
  before_action :set_post
  # TODO: are unpublished posts visable?
  # before_action :authorize_post, except: [:show]

  def show
    @logo_url =
      if @page.logo
        ActionController::Base.helpers.image_path(@page.logo.url(:medium))
      else
        ActionController::Base.helpers.image_path('mtgcast-logo-itunes.png')
      end
  end
end
