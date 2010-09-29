class CreateServerRacks < ActiveRecord::Migration
  def self.up
    create_table :server_racks do |t|
      t.integer :datacenter_id, :null => false, :options => "CONSTRAINT fk_server_rack_datacenter REFERENCES datacenters(id)"
      t.string :name
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :server_racks
  end
end
