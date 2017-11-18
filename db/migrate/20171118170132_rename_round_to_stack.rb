class RenameRoundToStack < ActiveRecord::Migration[5.1]
  def change
    rename_table :rounds, :stacks
  end
end
