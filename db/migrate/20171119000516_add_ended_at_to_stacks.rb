class AddEndedAtToStacks < ActiveRecord::Migration[5.1]
  def change
    add_column :stacks, :ended_at, :datetime
    add_index :stacks, :ended_at
  end
end
