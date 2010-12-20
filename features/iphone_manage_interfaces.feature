Feature: Manage interfaces
  In order to see my connections between devices and their interfaces
  as a mobile system admin
  I want to manage the interfaces and their connections

Background: 
	Given I am a user_with_acces
	Given I am using an iPhone
	Given a datacenter exist
	And a server_rack exist with name: "Rack", datacenter: the datacenter
	And 42 units exist with server_rack: the server_rack

Scenario: Connect two interfaces
	And a  "2"U device exists inside the server_rack with name: "Testdevice"
	Then a device should exist
	And an interface exists with device: the device, interface_type: 1, name: "eth0"
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack"
	And I follow "Add device"
	When I fill in "device_name" with "Connected server"
	And I fill in "device_comment" with "This device is connected to the testserver"
	And I check "3"
	And I press "Save"
	And I should see "3: Server: Connected server"
	Given I am using an iPhone
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack"
	And I follow "Connected server"
	And I follow "Add interface"
	When I fill in "interface_name" with "eth0"
	And I select "Testdevice: eth0" from "interface_connected_to"
	And I select "Blue" from "interface_cable_connection_color"
	And I press "Save"
	And I should see "eth0 Testdevice: eth0"
	And I should see "eth0 Connected server: eth0"

Scenario: Disconnect an interface
	And a  "2"U device exists inside the server_rack with name: "Left device"
	Then a device should exist with name: "Left device"
	And an interface "left_ethernet" exists with device: the device, interface_type: 1, name: "left ethernet"
	And a  "2"U device exists inside the server_rack with name: "Right device"
	Then a device should exist with name: "Right device"
	And an interface "right_ethernet" exists with device: the device, interface_type: 1, name: "right ethernet"
	And a cable_connection between the two with color: "Yellow"
	And I am on the home page
	And I follow "Datacenter"
	And I follow "Rack"
	And I follow "Left device"
	Then I should see "left ethernet right ethernet on Right device"
	When I follow "Edit" within "[@class='interface_controls']"
	And I select "disconnect" from "interface_connected_to" 
	And I press "Save"
	Then I should see "left ethernet"

Scenario: Delete an interface with a connection
	And a  "2"U device exists inside the server_rack with name: "Left device"
	And an interface "left_ethernet" exists with device_id: 1, interface_type: 1, name: "left ethernet"
	And a  "2"U device exists inside the server_rack with name: "right device"
	And an interface "right_ethernet" exists with device_id: 2, interface_type: 1, name: "right ethernet"
	And a cable_connection between the two with color: "Yellow"
	And I am on the home page
	And I follow "Datacenter"
	And I follow "Rack"
	And I follow "Left device"
	Then I should see "left ethernet right ethernet on right device"
	When I follow "Delete" within "[@class='interface_controls']"
	Then I should not see "left ethernet"

Scenario: reconnect an interface
	And a  "2"U device exists inside the server_rack with name: "Left device"
	And an interface "left_ethernet" exists with device_id: 1, interface_type: 1, name: "left ethernet"
	And a  "2"U device exists inside the server_rack with name: "right device"
	And an interface "right_ethernet" exists with device_id: 2, interface_type: 1, name: "right ethernet"
	And a cable_connection between the two with color: "Yellow"
	And a  "2"U device exists inside the server_rack with name: "Third device"
	And an interface exists with device_id: 3, interface_type: 1, name: "new connection"
	And I am on the home page
	And I follow "Datacenter"
	And I follow "Rack"
	And I follow "Left device"
	Then I should see "left ethernet right ethernet on right device"
	When I follow "Edit" within "[@class='interface_controls']"
	And I select "Third device: new connection" from "interface_connected_to" 
	And I press "Save"
	Then I should see "left ethernet Third device: new connection"
	And I should not see "right ethernet Left device: left ethernet"