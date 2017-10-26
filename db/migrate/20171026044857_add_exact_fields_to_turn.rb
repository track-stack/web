class AddExactFieldsToTurn < ActiveRecord::Migration[5.1]
  def change
    add_column :turns, :exact_name_match, :string
    add_column :turns, :exact_artist_match, :string

    add_index :turns, :exact_name_match
    add_index :turns, :exact_artist_match
  end
end
