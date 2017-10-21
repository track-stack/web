class DropGameInvites < ActiveRecord::Migration[5.1]
  def change
    drop_table :game_invites
  end
end
