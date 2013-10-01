class DevicesCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies_devices, :id => false do |t|
      t.integer :device_id
      t.integer :company_id
    end
    remove_column :devices, :company_id
  end

  def self.down
    add_column :devices, :company_id, :integer
    drop_table :companies_devices
  end

end
