module DevicesHelper
  def possible_interfaces(selected_server_rack=nil)
    if !selected_server_rack || selected_server_rack == @device.server_rack
      @interfaces = @device.server_rack.available_interfaces + @device.connected_to_interfaces - @device.interfaces
    else
      @interfaces = selected_server_rack.available_interfaces
    end
  end
end
