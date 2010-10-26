Feature: Manage interfaces
  In order to see my connections between devices and their interfaces
  as a mobile system admin
  I want to manage the interfaces and their connections

Scenario: Connect two interfaces
	Given I am using an iPhone
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And a device exists with name: "Testdevice"
	And an interface exists with device: the device, interface_type: 1, name: "eth0"
	And 38 units exist with server_rack: the server_rack
	And 2 units exist with server_rack: the server_rack, device: the device
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack"
	And I follow "Add device"
	When I fill in "device_name" with "Connected server"
	And I fill in "device_comment" with "This device is connected to the testserver"
	And I check "unit_1"
	And I press "Save"
	And I should see "1 - 1: Server: Connected server"
	Given I am using an iPhone
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack"
	And I follow "Connected server"
	And I follow "Add interface"
	When I fill in "interface_name" with "eth0"
	And I select "eth0 on Testdevice" from "interface_connected_to"
	And I fill in "interface_cable_connection_color" with "Blue"
	And I press "Save"
	And I should see "eth0 ~ eth0 on Testdevice"
	And I should see "eth0 ~ eth0 on Connected server"

Scenario: Disconnect an interface
	Given I am using an iPhone
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And a device exists with name: "Left device"
	And an interface "left_ethernet" exists with device: the device, interface_type: 1, name: "left ethernet"
	And 2 units exist with server_rack: the server_rack, device: the device
	And a device exists with name: "right device"
	And an interface "right_ethernet" exists with device: the device, interface_type: 1, name: "right ethernet"
	And 2 units exist with server_rack: the server_rack, device: the device
	And a cable_connection exists with left_interface_id: 1, right_interface_id: 2, color: "Yellow"
	And I am on the home page
	And I follow "Datacenter"
	And I follow "Rack"
	And I follow "Left device"
	Then I should see "left ethernet right ethernet on right device"
	When I follow "Edit" within "div/div/div"
	And I select "disconnect" from "interface_connected_to" 
	And I press "Save"
	Then I should see "left ethernet"


Scenario: Delete an interface with a connection
	Given I am using an iPhone
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And a device exists with name: "Left device"
	And an interface "left_ethernet" exists with device: the device, interface_type: 1, name: "left ethernet"
	And 2 units exist with server_rack: the server_rack, device: the device
	And a device exists with name: "right device"
	And an interface "right_ethernet" exists with device: the device, interface_type: 1, name: "right ethernet"
	And 2 units exist with server_rack: the server_rack, device: the device
	And a cable_connection exists with left_interface_id: 1, right_interface_id: 2, color: "Yellow"
	And I am on the home page
	And I follow "Datacenter"
	And I follow "Rack"
	And I follow "Left device"
	Then I should see "left ethernet right ethernet on right device"
	When I follow "Delete" within "div/div/div"
	Then I should not see "left ethernet"

Scenario: reconnect an interface
	Given I am using an iPhone
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And a device exists with name: "Left device"
	And an interface exists with device: the device, interface_type: 1, name: "left ethernet"
	And 2 units exist with server_rack: the server_rack, device: the device
	And a device exists with name: "right device"
	And an interface exists with device: the device, interface_type: 1, name: "right ethernet"
	And 2 units exist with server_rack: the server_rack, device: the device
	And a device exists with name: "Third device"
	And an interface exists with device: the device, interface_type: 1, name: "new connection"
	And 2 units exist with server_rack: the server_rack, device: the device
	And a cable_connection exists with left_interface_id: 1, right_interface_id: 2, color: "Yellow"
	And I am on the home page
	And I follow "Datacenter"
	And I follow "Rack"
	And I follow "Left device"
	Then I should see "left ethernet right ethernet on right device"
	When I follow "Edit" within "div/div/div"
	And I select "new connection on Third device" from "interface_connected_to" 
	And I press "Save"
	Then I should see "left ethernet ~ new connection on Third device"
	And I should not see "right ethernet ~ left ethernet on Left device"