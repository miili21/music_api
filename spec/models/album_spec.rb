require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'validations' do
    it 'is valid with a title' do
      album = Album.new(title: 'Test Album')
      expect(album).to be_valid
    end

    it 'is invalid without a title' do
      album = Album.new(title: nil)
      expect(album).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many releases' do
      association = described_class.reflect_on_association(:releases)
      expect(association.macro).to eq(:has_many)
    end
  end
end