class Release < ApplicationRecord
  belongs_to :album

  has_many :artist_releases, dependent: :destroy
  has_many :artists, through: :artist_releases

  validates :title, presence: true
  validates :release_date, presence: true

  scope :past, -> { where("release_date < ?", Date.today) }
  scope :upcoming, -> { where("release_date >= ?", Date.today) }
end