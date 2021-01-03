module SidebarHelper
  def episodes_paths?(page)
    page && page.persisted? &&
      (
        current_page?(page_dashboard_audio_posts_path(page)) ||
        current_page?(new_page_dashboard_audio_post_path(page))
      )
  end

  def posts_paths?(page)
    page && page.persisted? &&
      (
        current_page?(page_dashboard_text_posts_path(page)) ||
        current_page?(new_page_dashboard_text_post_path(page))
      )
  end

  def page_settings_paths?(page)
    page && page.persisted? &&
      (
        current_page?(page_dashboard_settings_path(page)) ||
        current_page?(edit_page_dashboard_settings_path(page)) ||
        current_page?(edit_page_dashboard_logo_path(page)) ||
        current_page?(new_page_dashboard_logo_path(page))
      )
  end
end
