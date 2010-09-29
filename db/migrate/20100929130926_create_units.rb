class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.integer :server_rack_id, :null => false, :options => "CONSTRAINT fk_unit_server_rack REFERENCES server_racks(id)"
      t.integer :number
      t.integer :device_id, :options => "CONSTRAINT fk_unit_device REFERENCES devices(id)"

      t.timestamps
    end
  end

  def self.down
    drop_table :units
  end
end
