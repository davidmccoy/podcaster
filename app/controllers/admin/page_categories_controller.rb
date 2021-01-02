# For CRUDing the Page --> Category connection
class Admin::PageCategoriesController < ApplicationController
  before_action :set_page

  # TODO: this is a super hacky create action. should be separated out into create and destroy.
  # we're restricting pages to a single category for now but, since we expect to support
  # multiple categories per page in the future, we use a has_many association, which makes
  # this action read even worse.
  def create
    category = Category.find_by(name: category_params[:name])
    category_page = @page.category_pages.first

    if category && !category_page
      @page.categories << category
      flash[:notice] = 'Successfully added category.'
    elsif category && category_page && category_page.update(category_id: category.id)
      flash[:notice] = 'Successfully updated category.'
    else
      flash[:alert] = 'Failed to created category.'
    end

    redirect_to edit_page_admin_settings_path(@page)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
