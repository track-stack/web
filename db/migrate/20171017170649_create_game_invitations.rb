class CreateGameInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :game_invitations do |t|
      t.integer :inviter_id, null: false
      t.integer :invitee_id, null: false
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :game_invitations, :inviter_id
    add_index :game_invitations, :invitee_id
    add_index :game_invitations, :status
  end
end
