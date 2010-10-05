Feature: Manage devices
  In order to see my connections between devices and their interfaces
  as a system admin
  I want to manage the devices

Scenario: Create a device
	Given 10 datacenters exist
	And 9 server_racks exist with datacenter_id: 1
	And 42 units exist with server_rack_id: 1
	And I am on the datacenters page
	#When I follow "Add device"
	Then show me the page
	

Scenario: Delete a device
	Given 10 datacenters exist
	And 9 server_racks exist with datacenter_id: 1
	And 42 devices exist with device_type: 1
	And 42 units exist with server_rack_id: 1
	And I am on the datacenters page
	Then show me the page
	When I follow "Destroy" within "fieldset"
	Then I should see "Server rack was successfully deleted."
	And I should not see "Rack1"

Scenario: Edit a rack
	Given 10 datacenters exist
	And 9 server_racks exist with datacenter_id: 1
	And I am on the datacenters page
	When I follow "Edit" within "fieldset"
	And I fill in "server_rack_name" with "Edited rack"
	And I press "Update Server rack"
	Then I should see "Server rack was successfully updated."
	And I should see "Edited rack"	
