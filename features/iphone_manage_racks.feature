Feature: Manage racks
  In order to see my devices and their interfaces
  as a system admin
  I want to manage the racks

Scenario: Create a rack
	Given I am a user_with_acces
	Given I am using an iPhone
	Given 10 datacenters exist
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Add rack"
	When I fill in "server_rack_name" with "New test rack"
	And I fill in "server_rack_comment" with "Some comment on the new rack"
	And I fill in "number_of_units" with "42"
	And I press "Save"
	And I should see "Available units: 42/42"
	And I should see "New test rack"

Scenario: Delete a rack
	Given I am a user_with_acces
	Given I am using an iPhone
	Given 10 datacenters exist
	And 1 server_racks exist with datacenter_id: 1
	And 42 units exist with server_rack: the server_rack
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack"
	When I follow "Delete" 
	And I should not see "Rack1"

Scenario: Edit a rack
	Given I am a user_with_acces
	Given I am using an iPhone
	Given 10 datacenters exist
	And 9 server_racks exist with datacenter_id: 1
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack"
	And I follow "Edit"
	And I fill in "server_rack_name" with "Edited rack"
	And I press "Save"
	And I should see "Edited rack"	
