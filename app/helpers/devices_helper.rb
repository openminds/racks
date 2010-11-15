module DevicesHelper
	def possible_interfaces
		@interfaces = @device.server_rack.available_interfaces + @device.connected_to_interfaces - @device.interfaces
	end
end
