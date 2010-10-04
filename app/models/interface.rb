class Interface < ActiveRecord::Base
	belongs_to :device
	#belongs_to :cable_connection, :dependent => :destroy
	
	after_save :update_cable_connection
	
	attr_accessor :connected_to
	attr_accessor :cable_connection_color
	
	
	enumerate :interface_type do
		value :id => 1, :name => 'Ethernet'
		value :id => 2, :name => 'Power'
	end
	
	def cable_connection
		CableConnection.first(:conditions => "left_interface_id = #{self.id} OR right_interface_id = #{self.id}")
	end
	
	def to_s
		"#{self.name} on #{self.device.name}"
	end
	
	def update_cable_connection
		if self.cable_connection.nil?
			if !(self.connected_to == '')
				new_connection = CableConnection.new
				new_connection.right_interface_id = self.id
				new_connection.left_interface_id = self.connected_to
				new_connection.color = self.cable_connection_color
				new_connection.save!
			end
		else
			if (self.connected_to == '')
				cable_connection.destroy
			else
				if cable_connection.right_interface_id == self.id
					cable_connection.left_interface_id = self.connected_to
				else
					cable_connection.right_interface_id = self.connected_to
				end
				cable_connection.save!
			end
		end
	end
end
