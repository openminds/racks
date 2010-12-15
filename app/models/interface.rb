class Interface < ActiveRecord::Base
	belongs_to :device
	before_destroy :destroy_cable_connections

	validates_presence_of :name, :message => "can't be blank"

	attr_accessor :connected_to
	attr_accessor :cable_connection_color

	enumerate :interface_type do
		value :id => 1, :name => 'Ethernet'
		value :id => 2, :name => 'Power'
	end

	class << self
		def available
			all.inject([]) do |interfaces, interface|
				interfaces << interface if interface.available?
				interfaces
			end
		end
	end
	
	def other
	 	if cable_connection
			other = cable_connection.other_interface(self)
		else
			other = nil
		end
		other
	end

	def cable_connection
		if self.id
			CableConnection.first(:conditions => "left_interface_id = #{self.id} OR right_interface_id = #{self.id}")
		else
			nil
		end
	end

	def available?
		cable_connection.nil?
	end

	def to_s
		"#{self.device.name}: #{self.name}"
	end

	def destroy_cable_connections
		unless cable_connection.nil? 
			to_destroy = cable_connection
			to_destroy.destroy
		end
	end

	def update_cable_connection
		if self.cable_connection.nil?
			if self.connected_to != '' && !self.connected_to.nil?
				new_connection = CableConnection.new
				new_connection.right_interface_id = self.id
				new_connection.left_interface_id = self.connected_to
				new_connection.color = self.cable_connection_color
				new_connection.save
			end
		else
			to_update = cable_connection
			if self.connected_to == '' || self.connected_to.nil?
				to_update.destroy
			else
				if to_update.right_interface_id == self.id
					to_update.update_attributes(:left_interface_id => self.connected_to, :color => self.cable_connection_color)
				else
					to_update.update_attributes(:right_interface_id => self.connected_to, :color => self.cable_connection_color)
				end
			end
		end
	end
end
