require 'rails_helper'

RSpec.describe ArtistRelease, type: :model do
  describe 'associations' do
    it 'belongs to artist' do
      association = described_class.reflect_on_association(:artist)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to release' do
      association = described_class.reflect_on_association(:release)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end