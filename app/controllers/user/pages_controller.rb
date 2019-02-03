#
class User::PagesController < ApplicationController
  before_action :set_page, except: [:index]

  def index
    @pages = current_user.pages
  end
end
