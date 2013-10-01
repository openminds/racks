Feature: Manage racks
  In order to see my devices and their interfaces
  as a system admin
  I want to manage the racks

Background:
	Given I am a user_with_acces
	Given I am using an iPhone
	Given a datacenter exist

Scenario: Create a rack
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
	And 1 server_racks exist with datacenter: the datacenter
	And 42 units exist with server_rack: the server_rack
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack"
	When I follow "Delete"
	And I should not see "Rack1"

Scenario: Edit a rack
	And 9 server_racks exist with datacenter: the datacenter
	And I am on the home page
	When I follow "Datacenter"
	And I follow "Rack1"
	And I follow "Edit"
	And I fill in "server_rack_name" with "Edited rack"
	And I press "Save"
	And I should see "Edited rack"
