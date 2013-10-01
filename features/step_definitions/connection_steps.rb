Given /^a cable_connection between the two with color: "([^"]*)"$/ do |color|
  cable_connection = CableConnection.new
  cable_connection.color = color
  cable_connection.right_interface_id = Interface.all.last.id
  cable_connection.left_interface_id = Interface.all.last.id - 1
  cable_connection.save!
end