require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      artist = Artist.new(name: 'Test Artist')
      expect(artist).to be_valid
    end

    it 'is invalid without a name' do
      artist = Artist.new(name: nil)
      expect(artist).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many releases through artist_releases' do
      association = described_class.reflect_on_association(:releases)
      expect(association.macro).to eq(:has_many)
    end
  end
end
