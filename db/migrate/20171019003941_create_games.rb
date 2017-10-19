class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :status

      t.timestamps
    end
    add_index :games, :status
  end
end
