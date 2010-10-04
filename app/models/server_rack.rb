class ServerRack < ActiveRecord::Base
	belongs_to :datacenter
	has_many :units, :dependent => :destroy
	
	def available_units
		units.where(:device_id => nil)
	end
	def devices
		rack_devices = Array.new
		current_device=nil
		units.each do |unit|
			if unit.device != current_device and !unit.device.nil?
				rack_devices << unit.device
			end
			current_device = unit.device
		end
		rack_devices
	end
	def available_interfaces
		available_interfaces = Array.new
		devices.each do |device|
			device.interfaces.each do |interface|
				if interface.cable_connection.nil?
					available_interfaces << interface
				end
			end
		end
		available_interfaces
	end
end
