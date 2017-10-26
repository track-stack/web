class AddFieldsToTurn < ActiveRecord::Migration[5.1]
  def change
    add_column :turns, :match, :json
    add_column :turns, :distance, :integer

    add_index :turns, :distance
  end
end
