class CreateTurns < ActiveRecord::Migration[5.1]
  def change
    create_table :turns do |t|
      t.integer :user_id
      t.integer :game_id
      t.string :answer

      t.timestamps
    end

    add_index :turns, :user_id
    add_index :turns, :game_id
  end
end
