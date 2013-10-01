class DowncaseCableConnectionColors < ActiveRecord::Migration
  def self.up
  CableConnection.all.each do |connection|
    connection.color = connection.color.downcase
    connection.save!
  end
  end

  def self.down
  end
end
