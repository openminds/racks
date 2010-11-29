class AddCustomerNumberToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :customer_number, :integer
  end

  def self.down
    remove_column :companies, :customer_number
  end
end
