class AddRightsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :rights, :string
  end

  def self.down
    remove_column :users, :rights
  end
end
