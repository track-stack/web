class CreateStackWinners < ActiveRecord::Migration[5.1]
  def change
    create_table :stack_winners do |t|
      t.integer :user_id
      t.integer :stack_id
      t.integer :score

      t.timestamps
    end

    add_index :stack_winners, :user_id
    add_index :stack_winners, :stack_id
  end
end
