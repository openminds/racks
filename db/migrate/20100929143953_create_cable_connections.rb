class CreateCableConnections < ActiveRecord::Migration
  def self.up
    create_table :cable_connections do |t|
      t.integer :left_interface_id, :null => false ,:options => "CONSTRAINT fk_connection_interface REFERENCES interfaces(id)"
      t.integer :right_interface_id, :null => false ,:options => "CONSTRAINT fk_connection_interface REFERENCES interfaces(id)"
      t.string :color

      t.timestamps
    end
  end

  def self.down
    drop_table :cable_connections
  end
end
