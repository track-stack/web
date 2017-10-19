class CreateUserGames < ActiveRecord::Migration[5.1]
  def change
    create_table :user_games do |t|
      t.integer :user_id
      t.integer :game_id
      t.boolean :creator, default: false

      t.timestamps
    end

    add_index :user_games, :user_id
    add_index :user_games, :game_id
  end
end
