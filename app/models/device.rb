class Device < ActiveRecord::Base
	has_many :units, :dependent => :nullify
	belongs_to :company
	has_many :interfaces, :dependent => :destroy
	accepts_nested_attributes_for :interfaces, :allow_destroy => true, :reject_if => proc { |attrs| attrs['name'].blank? }
	
	after_save :update_cable_connection
	
	enumerate :device_type, :with => DeviceType
	
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
