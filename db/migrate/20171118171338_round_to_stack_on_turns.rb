class RoundToStackOnTurns < ActiveRecord::Migration[5.1]
  def change
    rename_column :turns, :round_id, :stack_id
  end
end
