class CreateReleases < ActiveRecord::Migration[8.1]
  def change
    create_table :releases do |t|
      t.string :title
      t.date :release_date
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
