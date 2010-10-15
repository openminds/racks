Feature: Manage racks
  In order to see my devices and their interfaces
  as a system admin
  I want to manage the racks

Scenario: Create a rack
	Given 10 datacenters exist
	And I am on the home page
	When I follow "Add rack"
	When I fill in "server_rack_name" with "New test rack"
	And I fill in "server_rack_comment" with "Some comment on the new rack"
	And I fill in "number_of_units" with "42"
	And I press "Create Server rack"
	Then I should see "Server rack was successfully created."
	And I should see "Available units: 42/42"
	And I should see "New test rack"

Scenario: Delete a rack
	Given 10 datacenters exist
	And 1 server_racks exist with datacenter_id: 1
	And 42 units exist with server_rack: the server_rack
	And I am on the home page
	When I follow "Destroy" within "fieldset" 
	Then I should see "Server rack was successfully destroyed."
	And I should not see "Rack1"

Scenario: Edit a rack
	Given 10 datacenters exist
	And 9 server_racks exist with datacenter_id: 1
	And I am on the home page
	When I follow "Edit" within "fieldset"
	And I fill in "server_rack_name" with "Edited rack"
	And I press "Update Server rack"
	Then I should see "Server rack was successfully updated."
	And I should see "Edited rack"	
