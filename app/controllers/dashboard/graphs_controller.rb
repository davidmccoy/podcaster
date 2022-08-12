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
                      .where.not(browser: nil)
                      .group(:audio_post_id)
                      .order('count_id desc')
                      .limit(5) # we should include excluded records as "other"
                      .count('id')
                      .transform_keys { |key| AudioPost.find(key).title }
  end

  def devices
    render json: @page.downloads
                      .where(created_at: start_date..end_date, feed_source: feed)
                      .where.not(browser: nil)
                      .group(:browser)
                      .order('count_id desc')
                      .limit(5) # we should include excluded records as "other"
                      .count('id')
  end

  def platforms
    render json: @page.downloads
                      .where(created_at: start_date..end_date, feed_source: feed)
                      .where.not(device_type: nil)
                      .group(:device_type)
                      .order('count_id desc')
                      .limit(5) # we should include excluded records as "other"
                      .count('id')
  end

  def referrers
    render json: @page.downloads
                      .where(created_at: start_date..end_date, feed_source: feed)
                      .where.not(referring_domain: nil)
                      .group(:referring_domain)
                      .order('count_id desc')
                      .limit(5) # we should include excluded records as "other"
                      .count('id')
  end

  def countries
    render json: @page.downloads
                      .where(created_at: start_date..end_date, feed_source: feed)
                      .where.not(browser: nil)
                      .group(:country)
                      .order('count_id desc')
                      .limit(5) # we should include excluded records as "other"
                      .count('id')
  end

  def dummy
    points = [rand(1..400), rand(1..400), rand(1..400), rand(1..400), rand(1..400)].sort.reverse
    render json: {
      "Point 1" => points[0],
      "Point 2" => points[1],
      "Point 3" => points[2],
      "Point 4" => points[3],
      "Point 5" => points[4],
    }
  end

  private

  def filter_params
    params.permit(:start_date, :end_date, :feed)
  end

  def start_date
    (current_user&.admin? && filter_params[:start_date]&.to_time&.beginning_of_day) || Time.zone.today.beginning_of_day - 7.days
  end

  def end_date
    (current_user&.admin? && filter_params[:end_date]&.to_time&.end_of_day) || Time.zone.today.end_of_day
  end

  def feed
    if current_user&.admin? && filter_params[:feed]
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
