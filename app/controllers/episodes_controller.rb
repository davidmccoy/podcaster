class EpisodesController < ApplicationController
  def create
    Episode.where(
      blubrry_filename: params[:filename],
      blubrry_file_url: params[:file_url]
    ).first_or_create
  end
end
