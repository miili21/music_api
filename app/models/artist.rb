class Artist < ApplicationRecord
  has_many :artist_releases, dependent: :destroy
  has_many :releases, through: :artist_releases

  validates :name, presence: true
end
