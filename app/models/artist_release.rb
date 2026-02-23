class ArtistRelease < ApplicationRecord
  belongs_to :artist
  belongs_to :release

  validates :artist_id, uniqueness: { scope: :release_id }
end