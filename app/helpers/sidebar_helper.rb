module SidebarHelper
  def episodes_paths?(page)
    page && page.persisted? &&
      (
        current_page?(page_posts_path(@page)) ||
        current_page?(new_page_post_path(@page))
      )
  end

  def page_settings_paths?(page)
    page && page.persisted? &&
      (
        current_page?(page_settings_path(@page)) ||
        current_page?(edit_page_path(@page)) ||
        current_page?(edit_page_logo_path(@page)) ||
        current_page?(new_page_logo_path(@page))
      )
  end
end
