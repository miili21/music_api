class Api::ReleasesController < ApplicationController
  def index
    releases = Release.includes(:album, :artists)

    # Filtering by release date
    if params[:filter] == "past"
      releases = releases.past
    elsif params[:filter] == "upcoming"
      releases = releases.upcoming
    end

    # Pagination with 10 records per page (default)
    releases = releases.page(params[:page]).per(params[:per_page] || 10)

    #JSON format
    render json: releases.as_json(
      include: {
        album: { only: [:id, :title] },
        artists: { only: [:id, :name] }
      },
      only: [:id, :title, :release_date]
    )
  end
end
