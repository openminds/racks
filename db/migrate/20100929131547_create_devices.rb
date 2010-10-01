class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.integer :company_id, :options => "CONSTRAINT fk_device_company REFERENCES companies(id)"
      t.integer :device_type
      t.string :name
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
