class ServerRack < ActiveRecord::Base
	belongs_to :datacenter
	has_many :units, :dependent => :destroy
	has_many :devices, :through => :units, :uniq => true
	# has_many :interfaces, :through => :devices // Not working
	validates_presence_of :name, :message => "can't be blank"

	def interfaces
		devices.map(&:interfaces).flatten
	end
	
	def available_interfaces
		devices.collect { |device|
			device.interfaces.available
		}.flatten
	end
	
	def cable_connections
		connections = Array.new
		interfaces.each do |interface|
			connections << CableConnection.first(:conditions => "left_interface_id = #{interface.id} OR right_interface_id = #{interface.id}")
		end
		connections.uniq.compact
	end
end
