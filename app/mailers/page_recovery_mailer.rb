class PageRecoveryMailer < ApplicationMailer
  def new_recovery_request(name, email, podcast_name, description)
    @name = name
    @email = email
    @podcast_name = podcast_name.blank? ? 'an Unlisted Podcast' : podcast_name
    @podcast = Page.find_by_name(@podcast_name)
    @description = description
    @url =
      if @podcast
        Rails.application.routes.url_helpers.page_url(slug: @podcast.slug)
      else
        nil
      end

    mail(to: 'david@hipstersofthecoast.com', subject: "A new recovery request has been made for #{@podcast_name}.")
  end
end
