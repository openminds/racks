Feature: Manage devices
  In order to see my connections between devices and their interfaces
  as a system admin
  I want to manage the devices

Scenario: Create a device
	Given 10 datacenters exist
	And a server_rack exist with datacenter_id: 1
	And 42 units exist with server_rack_id: 1
	And I am on the datacenters page
	Then show me the page
	When I follow "Add device"
	Then show me the page
	

Scenario: Delete a device
	Given 10 datacenters exist
	And 9 server_racks exist with datacenter_id: 1
	And 42 devices exist with device_type: 1
	And 42 units exist with server_rack_id: 1
	And I am on the datacenters page
	Then show me the page


