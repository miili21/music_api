class AddNotNullConstraints < ActiveRecord::Migration[8.0]
  def change
    change_column_null :artists, :name, false
    change_column_null :albums, :title, false
    change_column_null :releases, :title, false
    change_column_null :releases, :release_date, false
  end
end
