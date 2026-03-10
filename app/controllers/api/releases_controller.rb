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

    # JSON format
    render json: releases.as_json(
      include: {
        album: { only: [ :id, :title ] },
        artists: { only: [ :id, :name ] }
      },
      only: [ :id, :title, :release_date ]
    )
  end

  def show
    release = Release.includes(:album, :artists).find(params[:id])

    render json: release.as_json(
      include: {
        album: { only: [ :id, :title ] },
        artists: { only: [ :id, :name ] }
      },
      only: [ :id, :title, :release_date ]
    )
  end

   private

  def not_found
    render json: { error: "Release not found" }, status: :not_found
  end
end
