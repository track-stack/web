class RemoveColumnDistance < ActiveRecord::Migration[5.1]
  def change
    remove_column :turns, :distance
  end
end
