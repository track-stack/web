class RenameGameInvitationsToGameInvites < ActiveRecord::Migration[5.1]
  def change
    rename_table :game_invitations, :game_invites
  end
end
