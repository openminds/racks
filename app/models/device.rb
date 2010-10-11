class Device < ActiveRecord::Base
	has_many :units, :dependent => :nullify
	belongs_to :company
	has_many :interfaces, :dependent => :destroy
	accepts_nested_attributes_for :interfaces, :allow_destroy => true, :reject_if => proc { |attrs| attrs['name'].blank? }
	
	validates_presence_of :name, :message => "can't be blank"
	
	
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
	
	def cable_connections
		interfaces.map(&:cable_connection).flatten.compact.uniq
	end
	
	def connected_to_interfaces
		connected_to = []
		interfaces.each do |interface|
			if interface.cable_connection
				connected_to << interface.cable_connection.other_interface(interface)
			end
		end
		connected_to
	end
	
	def server_rack
		units.first.server_rack
	end
	
	def update_cable_connection
		self.interfaces.each do |i|
			i.update_cable_connection
		end
	end
end
