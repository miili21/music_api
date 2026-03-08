require 'rails_helper'

RSpec.describe "Api::Releases", type: :request do

  describe "GET /api/releases" do
    it "returns all releases" do
      album = Album.create!(title: "Test Album")

      Release.create!(
        title: "Test Release",
        release_date: Date.today,
        album: album
      )

      get "/api/releases"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first["title"]).to eq("Test Release")
    end
  end


  describe "GET /api/releases/:id" do
    it "returns a specific release" do
      album = Album.create!(title: "Test Album")
      artist = Artist.create!(name: "Test Artist")

      release = Release.create!(
        title: "Test Release",
        release_date: Date.today,
        album: album
      )

      release.artists << artist

      get "/api/releases/#{release.id}"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json["title"]).to eq("Test Release")
    end
  end


  describe "GET /api/releases with filter" do
    it "returns only past releases" do
      album = Album.create!(title: "Test Album")

      Release.create!(
        title: "Past Release",
        release_date: 2.years.ago,
        album: album
      )

      Release.create!(
        title: "Future Release",
        release_date: 2.years.from_now,
        album: album
      )

      get "/api/releases?filter=past"

      json = JSON.parse(response.body)

      expect(json.length).to eq(1)
      expect(json.first["title"]).to eq("Past Release")
    end
  end


  describe "GET /api/releases pagination" do
    it "limits number of releases returned" do
      album = Album.create!(title: "Test Album")

      3.times do |i|
        Release.create!(
          title: "Release #{i}",
          release_date: Date.today,
          album: album
        )
      end

      get "/api/releases?per_page=1"

      json = JSON.parse(response.body)

      expect(json.length).to eq(1)
    end
  end

end