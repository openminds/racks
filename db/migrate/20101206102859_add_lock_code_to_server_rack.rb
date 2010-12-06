class AddLockCodeToServerRack < ActiveRecord::Migration
  def self.up
    add_column :server_racks, :lock_code, :Integer
  end

  def self.down
    remove_column :server_racks, :lock_code
  end
end
