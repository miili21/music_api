require 'rails_helper'

RSpec.describe "Api::Releases", type: :request do
  let(:json) { JSON.parse(response.body) }
  
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
      expect(json.first["title"]).to eq("Test Release")
    end
  end

  describe "GET /api/releases/:id" do
    let(:album) { Album.create!(title: "Test Album") }
    let(:artist) { Artist.create!(name: "Test Artist") }
    let(:release) do
      r = Release.create!(title: "Test Release", release_date: Date.today, album: album)
      r.artists << artist
      r
    end

    it "returns a specific release" do
      get "/api/releases/#{release.id}"
      expect(response).to have_http_status(:ok)
      expect(json["title"]).to eq("Test Release")
    end

    it "returns a 404 when the release is not found" do
      get "/api/releases/999999"
      
      expect(response).to have_http_status(:not_found)
      expect(json['error']).to eq("Not found")
    end

    it "includes the expected nested data (album and artists)" do
      get "/api/releases/#{release.id}"

      expect(json).to have_key('album')
      expect(json['album']).to have_key('title')
      expect(json['artists'].first).to have_key('name')
    end
  end

  describe "GET /api/releases with filter" do
    let(:album) { Album.create!(title: "Test Album") }

    it "returns only past releases" do
      # Corregido: Release en lugar de aRelease
      Release.create!(title: "Past", release_date: 2.years.ago, album: album)
      Release.create!(title: "Future", release_date: 2.years.from_now, album: album)

      get "/api/releases", params: { filter: "past" }

      expect(json.length).to eq(1)
      expect(json.first["title"]).to eq("Past")
    end

    it "returns only upcoming releases when filtered" do
      Release.create!(title: "Upcoming", release_date: 1.year.from_now, album: album)
      Release.create!(title: "Old", release_date: 1.year.ago, album: album)

      get "/api/releases", params: { filter: "upcoming" }

      json.each do |r|
        expect(Date.parse(r['release_date'])).to be >= Date.today
      end
    end 
  end 

  describe "GET /api/releases pagination" do
    it "limits number of releases returned" do
      album = Album.create!(title: "Test Album")
      3.times { |i| Release.create!(title: "R#{i}", release_date: Date.today, album: album) }
        
      # Corregido: params con una sola 'a' y formato correcto
      get "/api/releases", params: { per_page: 1 }
      expect(json.length).to eq(1)
    end
  end
end