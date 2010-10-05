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
	


