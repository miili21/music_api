require 'rails_helper'

RSpec.describe Release, type: :model do
  describe 'validations' do
    it 'is valid with title and release_date' do
      album = Album.create!(title: 'Album')
      release = Release.new(
        title: 'Test Release',
        release_date: Date.today,
        album: album
      )
      expect(release).to be_valid
    end

    it 'is invalid without a title' do
      album = Album.create!(title: 'Album')
      release = Release.new(
        title: nil,
        release_date: Date.today,
        album: album
      )
      expect(release).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to album' do
      association = described_class.reflect_on_association(:album)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
