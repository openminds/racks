Feature: Manage devices
  In order to see my connections between devices and their interfaces
  as a mobile system admin
  I want to manage the devices

Background:
	Given I am a user_with_acces
	Given I am using an iPhone

Scenario: Create a device
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And 42 units exist with server_rack: the server_rack
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack1"
	When I follow "Add device"
	When I fill in "device_name" with "Testserver"
	And I fill in "device_comment" with "Some comment for the restserver"
	And I check "unit_1"
	And I press "Save"
	And I should see "1: Server: Testserver"

	
Scenario: Delete a device
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And 12 devices exist
	And 42 units exist with server_rack: the server_rack, device: a device
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack"
	Then I should see "Available units: 0/42"
	When I follow "Device1"
	When I follow "Delete"
	And I should see "Available units: 42/42"

Scenario: Update a device
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And a device exists
	And 42 units exist with server_rack: the server_rack, device: the device
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack"
	Then I should see "Available units: 0/42"
	When I follow "Device"
	When I follow "Edit"
	When I fill in "device_name" with "Updated device name"
	And I fill in "device_comment" with "Updated device comment"
	And I press "Save"
	And I should see "Updated device name"
	And I should see "Updated device comment"
	

Scenario: Create a device using 2 units
	Given a datacenter exist
	And a server_rack exist with datacenter: the datacenter
	And 42 units exist with server_rack: the server_rack
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack"
	Then I should see "Available units: 42/42"
	When I follow "Add device"
	When I fill in "device_name" with "Testserver"
	And I fill in "device_comment" with "Some comment for the restserver"
	And I check "unit_1"
	And I press "Save"
	And I should see "1: Server: Testserver"

