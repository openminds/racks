Feature: Manage devices
  In order to see my connections between devices and their interfaces
  as a system admin
  I want to manage the devices

Background:
	Given I am a user_with_acces
	And I am using a regular browser
	And a datacenter exist
	And a server_rack exist with datacenter: the datacenter, name: "devices testrack"
	And 42 units exist with server_rack: the server_rack

Scenario: Create a device without any interfaces
	And I am on the home page
	When I follow "Add device"
	When I fill in "device_name" with "Testserver"
	And I fill in "device_comment" with "Some comment for ipthe restserver"
	And I select "1" from "device_unit_ids"
	And I press "Create Device"
	Then I should see "Device was successfully created."
	And I should see "1: Server: Testserver"

	
Scenario: Delete a device
	Given a  "42"U device exists inside the server_rack with name: "Device1"
	And I am on the datacenters page
	Then I should see "Available units: 0/42"
	When I follow "Destroy" within "fieldset/div/div"
	Then I should see "Device was successfully destroyed."
	And I should see "Available units: 42/42"

Scenario: Update a device
	Given a  "42"U device exists inside the server_rack with name: "Device1"
	And I am on the home page
	Then I should see "Available units: 0/42"
	When I follow "Edit" within "fieldset/div/div"
	When I fill in "device_name" with "Updated device name"
	And I fill in "device_comment" with "Updated device comment"
	And I press "Update Device"
	Then I should see "Device was successfully updated."
	And I should see "Updated device name"
	And I should see "Updated device comment"
	

Scenario: Create a device with an interface
	And I am on the home page
	When I follow "Add device"
	When I fill in "device_name" with "Testserver"
	And I fill in "device_comment" with "Some comment for the restserver"
	And I select "1" from "device_unit_ids"
	And I fill in "device_interfaces_attributes_0_name" with "eth0"
	And I press "Create Device"
	Then I should see "Device was successfully created."
	And I should see "1: Server: Testserver"
	And I should see "eth0"

Scenario: Create a device with an interface and a connection
	Given a  "1"U device exists inside the server_rack with name: "Testdevice"
	Then a device should exist
	And an interface exists with device: the device, interface_type: 1, name: "eth0"
	And I am on the home page
	And I follow "Add device"
	When I fill in "device_name" with "Connected server"
	And I fill in "device_comment" with "This device is connected to the testserver"
	And I select "3" from "device_unit_ids"
	And I fill in "device_interfaces_attributes_0_name" with "eth0"
	And I select "Testdevice: eth0" from "device_interfaces_attributes_0_connected_to"
	And I fill in "device_interfaces_attributes_0_cable_connection_color" with "Yellow"
	And I press "Create Device"
	Then I should see "Device was successfully created."
	And I should see "3: Server: Connected server"
	And I should see "eth0 Testdevice: eth0"
	And I should see "eth0 Connected server: eth0"

Scenario: Disconnect an interface
	Given a  "1"U device exists inside the server_rack with name: "Left device"
	And an interface: "left ethernet" exists with name: "left ethernet", device_id: 1, interface_type: 1
	Given a  "1"U device exists inside the server_rack with name: "right device"
	And an interface: "right ethernet" exists with name: "right ethernet", device_id: 2, interface_type: 1
	And a cable_connection between the two with color: "Yellow"
	And I am on the home page
	Then I should see "left ethernet right device: right ethernet"
	And I should see "right ethernet Left device: left ethernet"
	When I follow "Edit" within "fieldset/div/div"
	And I select "disconnect" from "device_interfaces_attributes_0_connected_to" 
	And I press "Update Device"
	Then I should see "Device was successfully updated."
	And I should not see "left ethernet right device: right ethernet"
	And I should not see "right ethernet Left device: left ethernet"

Scenario: Delete an interface with a connection
	Given a  "1"U device exists inside the server_rack with name: "Left device"
	And an interface: "left ethernet" exists with name: "left ethernet", device_id: 1, interface_type: 1
	Given a  "1"U device exists inside the server_rack with name: "right device"
	And an interface: "right ethernet" exists with name: "right ethernet", device_id: 2, interface_type: 1
	And a cable_connection between the two with color: "Yellow"
	And I am on the home page
	Then I should see "left ethernet right device: right ethernet"
	And I should see "ight ethernet Left device: left ethernet"
	When I follow "Edit" within "fieldset/div/div"
	And I check "device_interfaces_attributes_0__destroy" 
	And I press "Update Device"
	Then I should see "Device was successfully updated."
	And I should not see "right ethernet Left device: left ethernet"
	When I follow "Datacenter management"
	Then I should see "right ethernet"

Scenario: reconnect an interface
	Given a  "1"U device exists inside the server_rack with name: "Left device"
	And an interface: "left ethernet" exists with name: "left ethernet", device_id: 1, interface_type: 1
	Given a  "1"U device exists inside the server_rack with name: "right device"
	And an interface: "right ethernet" exists with name: "right ethernet", device_id: 2, interface_type: 1
	And a cable_connection between the two with color: "Yellow"
	And a  "1"U device exists inside the server_rack with name: "Third device"
	And an interface exists with device_id: 3, interface_type: 1, name: "new connection"
	And I am on the home page
	Then I should see "left ethernet right device: right ethernet"
	And I should see "right ethernet Left device: left ethernet"
	When I follow "Edit" within "fieldset/div/div"
	And I select "Third device: new connection" from "device_interfaces_attributes_0_connected_to" 
	And I press "Update Device"
	Then I should see "left ethernet Third device: new connection"
	And I should not see "right ethernet Left device: left ethernet"

Scenario: Trying to create an invalid device
	And I am on the home page
	When I follow "Add device"
	And I press "Create Device"
	Then I should see "Name can't be blank"

Scenario: Trying to make an existing device invalid
	Given a  "42"U device exists inside the server_rack with name: "Device1"
	And I am on the home page
	Then I should see "Available units: 0/42"
	When I follow "Edit" within "fieldset/div/div"
	When I fill in "device_name" with ""
	And I fill in "device_comment" with "Updated device comment"
	And I press "Update Device"
	Then I should see "Name can't be blank"
	
@javascript
Scenario: Adding a device with multiple interfaces
	And I am on the home page
	When I follow "Add device"
	When I fill in "device_name" with "Testserver"
	And I fill in "device_comment" with "Some comment for the testserver"
	And I select "1" from "device_unit_ids"
	When I follow "Interfaces"
	Then I should see "Interface Type?"
	When I select "Ethernet" from "device_interfaces_attributes_0_interface_type"
	Then the "device_interfaces_attributes_0_name" field should contain "eth1"
	When I follow "Add Interface"
	Then I should see "Interface Type?"
	When I select "Ethernet" from "device_interfaces_attributes_1_interface_type"
	Then the "device_interfaces_attributes_1_name" field should contain "eth2"
	When I fill in "device_interfaces_attributes_1_name" with "adjusted"
	When I press "Create Device"
	Then I should see "Device was successfully created."
	And I should see "1: Server: Testserver"
	And I should see "eth1"
	And I should see "adjusted"

@javascript
Scenario: Connecting a device when creating it with multiple interfaces
	Given a  "2"U device exists inside the server_rack with name: "Testdevice"
	And an interface exists with device_id: 1, interface_type: 1, name: "eth1"
	And I am on the home page
	When I follow "Add device"
	When I fill in "device_name" with "Testserver"
	And I fill in "device_comment" with "Some comment for the testserver"
	And I select "3" from "device_unit_ids"
	When I follow "Interfaces"
	And I select "Ethernet" from "device_interfaces_attributes_0_interface_type"
	And I follow "Add Interface"
	When I select "Ethernet" from "device_interfaces_attributes_1_interface_type"
	And I select "Testdevice: eth1" from "device_interfaces_attributes_1_connected_to"
	And I fill in "device_interfaces_attributes_1_cable_connection_color" with "black"
	And I press "Create Device"
	Then I should see "3: Server: Testserver"
	And I should see "eth2 Testdevice: eth1"
	
@javascript
Scenario: When selecting an interface type, other types should be disabled
	Given a  "2"U device exists inside the server_rack with name: "Testdevice"
	And an interface exists with device_id: 1, interface_type: 2, name: "pw1"
	And an interface exists with device_id: 1, interface_type: 1, name: "eth1"
	And I am on the home page
	When I follow "Add device"
	When I fill in "device_name" with "Testserver"
	And I fill in "device_comment" with "Some comment for the testserver"
	And I select "3" from "device_unit_ids"
	When I follow "Interfaces"
	And I select "Power" from "device_interfaces_attributes_0_interface_type"
	Then option "Testdevice: pw1" from "device_interfaces_attributes_0_connected_to" should be enabled
	And option "Testdevice: eth1" from "device_interfaces_attributes_0_connected_to" should be disabled
	And I follow "Add Interface"
	When I select "Ethernet" from "device_interfaces_attributes_1_interface_type"
	Then option "Testdevice: pw1" from "device_interfaces_attributes_1_connected_to" should be disabled
	And option "Testdevice: eth1" from "device_interfaces_attributes_1_connected_to" should be enabled
	When I select "Testdevice: pw1" from "device_interfaces_attributes_0_connected_to"
	And I fill in "device_interfaces_attributes_0_cable_connection_color" with "black"
	And I select "Testdevice: eth1" from "device_interfaces_attributes_1_connected_to"
	And I fill in "device_interfaces_attributes_1_cable_connection_color" with "black"
	And I press "Create Device"
	Then I should see "3: Server: Testserver"
	And I should see "PW1 Testdevice: pw1"
	And I should see "eth1 Testdevice: eth1"

@javascript
Scenario: Connecting an interface to a device inside a different rack
	Given a  "2"U device exists inside the server_rack with name: "Testdevice"
	And an interface exists with device_id: 1, interface_type: 2, name: "pw1"
	And an interface exists with device_id: 1, interface_type: 1, name: "eth1"
	And I am on the home page
	When I follow "Add rack"
	And I fill in "server_rack_name" with "Second rack"
	And I fill in "server_rack_comment" with "I will try to connect something in this rack to the other rack"
	And I fill in "number_of_units" with "42"
	And I press "Create Server rack"
	Then I should see "Second rack"
	When I follow "Add device"
	When I fill in "device_name" with "Second server"
	And I fill in "device_comment" with "Some comment for the testserverer"
	And I select "1" from "device_unit_ids"
	When I follow "Interfaces"
	Then I should see "Interface Type?"
	When I select "Ethernet" from "device_interfaces_attributes_0_interface_type"
	Then the "device_interfaces_attributes_0_name" field should contain "eth1"
	When I select "devices testrack" from "device_interfaces_attributes_0_selected_server_rack"
	Then option "Testdevice: pw1" from "device_interfaces_attributes_0_connected_to" should be disabled
	And option "Testdevice: eth1" from "device_interfaces_attributes_0_connected_to" should be enabled
	When I select "Testdevice: eth1" from "device_interfaces_attributes_0_connected_to"
	And I fill in "device_interfaces_attributes_0_cable_connection_color" with "black"
	And I press "Create Device"
	Then I should see "eth1 Testdevice: eth1"

@javascript
Scenario: Adding a device while quickly adding multiple interfaces
	And I am on the home page
	When I follow "Add device"
	When I fill in "device_name" with "Testserver"
	And I fill in "device_comment" with "Some comment for the testserver"
	And I select "1" from "device_unit_ids"
	When I follow "Interfaces"
	Then I should see "Ethernet interfaces:"
	When I fill in "count_ethernet_interfaces" with "24"
	And I fill in "count_power_interfaces" with "12"
	And I follow "Create interfaces"
	And I press "Create Device"
	Then the device should have "24" "Ethernet" interfaces
	And the device should have "12" "Power" interfaces

@javascript	
Scenario: Trying to add a de no name but wited interfaces
	Given a  "2"U device exists inside the server_rack with name: "Testdevice"
	And an interface exists with device_id: 1, interface_type: 1, name: "eth1"
	And I am on the home page
	When I follow "Add device"
	And I select "3" from "device_unit_ids"
	When I follow "Interfaces"
	And I select "Ethernet" from "device_interfaces_attributes_0_interface_type"
	And I follow "Add Interface"
	When I select "Ethernet" from "device_interfaces_attributes_1_interface_type"
	And I select "Testdevice: eth1" from "device_interfaces_attributes_1_connected_to"
	And I fill in "device_interfaces_attributes_1_cable_connection_color" with "black"
	And I press "Create Device"
	Then I should see "Name can't be blank"
