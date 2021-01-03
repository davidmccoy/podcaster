module ApplicationHelper
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge renderer: WillPaginate::ActionView::BootstrapLinkRenderer
    end
    super *[collection_or_options, options].compact
  end

  # checks if the current path is for page management
  def page_management_path?(page, post)
    (page && page.persisted? &&
      (current_page?(page_dashboard_posts_url(page)) ||
        current_page?(page_dashboard_text_posts_url(page)) ||
        current_page?(new_page_dashboard_post_url(page)) ||
        current_page?(page_dashboard_stats_path(page)) ||
        current_page?(page_dashboard_settings_path(page)) ||
        current_page?(new_page_dashboard_logo_path(page)) ||
        current_page?(edit_page_dashboard_logo_path(page)) ||
        current_page?(delete_page_dashboard_settings_path(page)) ||
        current_page?(edit_page_dashboard_settings_path(page)) ||
        current_page?(new_page_dashboard_text_post_url(page))
      )
    ) || (page && page.persisted? &&
      (
        post &&
          (
            post.audio_post? ? current_page?(edit_page_dashboard_post_url(page, post)) : current_page?(edit_page_dashboard_text_post_url(page, post))
          )
      )
    )
  end

  def categories_for_select
    [
      [
        'Constructed',
        [
          'All Constructed',
          'Historic',
          'Legacy',
          'Modern',
          'Pauper',
          'Pioneer',
          'Standard',
          'Vintage',
        ]
      ],
      [
        'Limited',
        [
          'All Limited',
          'Booster Draft',
          'Cube',
          'Sealed',
        ]
      ],
      [
        'Singleton',
        [
          'All Singleton',
          'cEDH',
          'Brawl',
          'Commander',
          'Historic Brawl',
        ]
      ],
      [
        'Culture',
        [
          'Community',
          'General Interest',
          'News',
          'Vorthos',
        ]
      ],
      [
        'Play Style',
        [
          'Casual',
          'Competitive',
        ]
      ],
      [
        'Platform',
        [
          'Arena',
          'Magic Online',
          'Tabletop',
        ]
      ],
    ]
  end
end
