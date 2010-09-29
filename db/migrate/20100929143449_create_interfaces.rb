class CreateInterfaces < ActiveRecord::Migration
  def self.up
    create_table :interfaces do |t|
      t.integer :device_id, :null => false ,:options => "CONSTRAINT fk_interface_device REFERENCES devices(id)"
      t.string :type
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :interfaces
  end
end
