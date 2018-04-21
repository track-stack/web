class RenameApnsTokenToExpoToken < ActiveRecord::Migration[5.1]
  def change
    remove_index :devices, :apns_token

    rename_column :devices, :apns_token, :expo_token

    add_index :devices, :expo_token
  end
end
