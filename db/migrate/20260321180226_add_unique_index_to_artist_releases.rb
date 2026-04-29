class AddUniqueIndexToArtistReleases < ActiveRecord::Migration[8.0]
  def change
    add_index :artist_releases, [ :artist_id, :release_id ], unique: true
  end
end
