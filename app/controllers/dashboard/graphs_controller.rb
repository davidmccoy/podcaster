# Only accessible by page admins
class Dashboard::GraphsController < ApplicationController
  before_action :set_page
  before_action :authorize_page

  def downloads
    render json: @page.downloads
                      .where(created_at: start_date..end_date, feed_source: feed)
                      .group_by_day(:created_at)
                      .count
  end

  def episodes
    render json: @page.downloads
                      .where(created_at: start_date..end_date, feed_source: feed)
                      .group(:audio_post_id)
                      .order('count_id desc')
                      .limit(5) # we should include excluded records as "other"
                      .count('id')
                      .transform_keys { |key| AudioPost.find(key).title }
  end

  def devices
    render json: @page.downloads
                      .where(created_at: start_date..end_date, feed_source: feed)
                      .group(:browser)
                      .order('count_id desc')
                      .limit(5) # we should include excluded records as "other"
                      .count('id')
  end

  def platforms
    render json: @page.downloads
                      .where(created_at: start_date..end_date, feed_source: feed)
                      .group(:device_type)
                      .order('count_id desc')
                      .limit(5) # we should include excluded records as "other"
                      .count('id')
  end

  def referrers
    render json: @page.downloads
                      .where(created_at: start_date..end_date, feed_source: feed)
                      .group(:referring_domain)
                      .order('count_id desc')
                      .limit(5) # we should include excluded records as "other"
                      .count('id')
  end

  def countries
    render json: @page.downloads
                      .where(created_at: start_date..end_date, feed_source: feed)
                      .group(:country)
                      .order('count_id desc')
                      .limit(5) # we should include excluded records as "other"
                      .count('id')
  end

  private

  def filter_params
    params.permit(:start_date, :end_date, :feed)
  end

  def start_date
    filter_params[:start_date] || Time.zone.today - 7.days
  end

  def end_date
    filter_params[:end_date] || Time.zone.today
  end

  def feed
    if filter_params[:feed]
      if filter_params[:feed] == 'Both'
        ['individual', 'aggregate_feed']
      else
        filter_params[:feed]
      end
    else
      ['individual', 'aggregate_feed']
    end
  end
end