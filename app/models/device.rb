class Device < ActiveRecord::Base
	has_many :units, :dependent => :nullify
	belongs_to :company
	has_many :interfaces, :dependent => :destroy
	accepts_nested_attributes_for :interfaces
	
	after_update :update_cable_connection
	
	enumerate :device_type do
		value :id => 1, :name => 'Server'
		value :id => 2, :name => 'Router'
		value :id => 3, :name => 'Switch'
		value :id => 4, :name => 'Powerbar'
		value :id => 5, :name => 'Rented out'
	end
	
	def unit_ids(ids=[])
		ids.each do |id|
			unit = Unit.find(id)
			units << unit
		end
	end
	def unit_ids
		ids = []
		units.each do |unit|
			ids << unit.id
		end
		ids
	end
	
	def server_rack
		ServerRack.find(units.first.server_rack.id)
	end
	
	def update_cable_connection
		self.interfaces.each do |i|
			i.update_cable_connection
		end
	end
end
