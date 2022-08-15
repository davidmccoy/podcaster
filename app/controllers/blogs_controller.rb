class BlogsController < ApplicationController
  def show
    @posts = page.posts.published.includes(:postable)
    .paginate(page: params[:page], per_page: 15)

    @logo_url =  ActionController::Base.helpers.image_path('mtgcast-logo-itunes.png')

    @shortened = @page.description&.to_plain_text&.length > 300

    render "pages/show"
  end

  def page
    @page = Page.find_by(slug: "mtgcast")
  end
end
