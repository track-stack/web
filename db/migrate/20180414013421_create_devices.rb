class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :device_id
      t.string :apns_token
      t.integer :user_id

      t.timestamps
    end

    add_index :devices, :device_id
    add_index :devices, :apns_token
    add_index :devices, :user_id

    add_foreign_key :devices, :users
  end
end
