class ServerRack < ActiveRecord::Base
	belongs_to :datacenter
	has_many :units, :dependent => :destroy
	validates_presence_of :name, :message => "can't be blank"

	# def available_units
	# 		units.where(:device_id => nil)
	# 	end
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
	def interfaces
		# interfaces = Array.new
		# 		devices.each do |device|
		# 			device.interfaces.each do |interface|
		# 				interfaces << interface
		# 			end
		# 		end
		# interfaces
		devices.inject([]) do |interfaces, device|
			interfaces << device.interfaces
			interfaces
		end
	end
	def available_interfaces
		# interfaces = Array.new
		# 		devices.each do |device|
		# 			device.interfaces.each do |interface|
		# 				if interface.cable_connection.nil?
		# 					interfaces << interface
		# 				end
		# 			end
		# 		end
		# interfaces
		interfaces.inject([]) do |available_interfaces, interface|
			available_interfaces << interface if interface.cable_connection.nil?
			available_interfaces
		end
	end
	def cable_connections
		connections = Array.new
		interfaces.each do |interface|
			connections << CableConnection.first(:conditions => "left_interface_id = #{interface.id} OR right_interface_id = #{interface.id}")
		end
		connections.uniq.compact
	end
end
