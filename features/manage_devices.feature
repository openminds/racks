Feature: Manage devices
  In order to see my connections between devices and their interfaces
  as a system admin
  I want to manage the devices

Scenario: Create a device without any interfaces
	Given 10 datacenters exist
	And a server_rack exist with datacenter_id: 1
	And 42 units exist with server_rack: the server_rack
	And I am on the datacenters page
	When I follow "Add device"
	When I fill in "device_name" with "Testserver"
	And I fill in "device_comment" with "Some comment for the restserver"
	And I select "1" from "device_unit_ids"
	And I press "Create Device"
	Then I should see "Device was successfully created."
	And I should see "1 - 1: Server: Testserver"

	
Scenario: Delete a device
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And 12 devices exist
	And 42 units exist with server_rack: the server_rack, device: a device
	And I am on the datacenters page
	Then I should see "Available units: 0/42"
	When I follow "Destroy" within "fieldset/div/div"
	Then I should see "Device was successfully deleted."
	And I should see "Available units: 42/42"
	
Scenario: Update a device
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And 12 devices exist
	And 42 units exist with server_rack: the server_rack, device: a device
	And I am on the datacenters page
	Then I should see "Available units: 0/42"
	When I follow "Edit" within "fieldset/div/div"
	When I fill in "device_name" with "Updated device name"
	And I fill in "device_comment" with "Updated device comment"
	And I press "Update Device"
	Then I should see "Device was successfully updated."
	And I should see "Updated device name"
	And I should see "Updated device comment"
	

Scenario: Create a device with an interface
	Given 10 datacenters exist
	And a server_rack exist with datacenter_id: 1
	And 42 units exist with server_rack: the server_rack
	And I am on the datacenters page
	When I follow "Add device"
	When I fill in "device_name" with "Testserver"
	And I fill in "device_comment" with "Some comment for the restserver"
	And I select "1" from "device_unit_ids"
	And I fill in "device_interfaces_attributes_0_name" with "eth0"
	And I press "Create Device"
	Then I should see "Device was successfully created."
	And I should see "1 - 1: Server: Testserver"
	And I should see "eth0"

Scenario: Create a device with an interface and a connection
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And a device exists with name: "Testdevice"
	And an interface exists with device: the device, interface_type: 1, name: "eth0"
	And 40 units exist with server_rack: the server_rack
	And 2 units exist with server_rack: the server_rack, device: the device
	And I am on the datacenters page
	And I follow "Add device"
	When I fill in "device_name" with "Connected server"
	And I fill in "device_comment" with "This device is connected to the testserver"
	And I select "1" from "device_unit_ids"
	And I fill in "device_interfaces_attributes_0_name" with "eth0"
	And I select "eth0 on Testdevice" from "device_interfaces_attributes_0_connected_to"
	And I fill in "device_interfaces_attributes_0_cable_connection_color" with "yellow"
	And I press "Create Device"
	Then I should see "Device was successfully created."
	And I should see "1 - 1: Server: Connected server"
	And I should see "eth0 ~ eth0 on Testdevice"
	And I should see "eth0 ~ eth0 on Connected server"
	
	
