class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.integer :game_id

      t.timestamps
    end

    add_index :rounds, :game_id
  end
end
