class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :telephone
      t.string :url
      t.string :btw_nr
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
