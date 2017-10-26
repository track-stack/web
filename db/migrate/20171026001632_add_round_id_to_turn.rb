class AddRoundIdToTurn < ActiveRecord::Migration[5.1]
  def change
    add_column :turns, :round_id, :integer
    add_index :turns, :round_id
  end
end
