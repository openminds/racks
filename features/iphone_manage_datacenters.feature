Feature: Manage datacenters
  In order to see my datacenters and their contents
  as a mobile system admin
  I want to manage the datacenters

Background:
	Given I am a user_with_acces
	Given I am using an iPhone

Scenario: Add a datacenter
	Given I am on the new datacenter page
	And I fill in "datacenter_name" with "Just a datacenter"
	And I fill in "datacenter_location" with "Brussels"
	And I fill in "datacenter_comment" with "Some comment"
	And I press "Save"
	Then I should see "Just a datacenter"

Scenario: Delete a datacenter
	Given 10 datacenters exist
	Given I am on the home page
	When I follow "Datacenter2"
	And I follow "Delete"
	Then I should not see "Datacenter2"

Scenario: Edit a datacenter
	Given 10 datacenters exist
	Given I am on the home page
	When I follow "Datacenter1"
	And I follow "Edit"
	And I fill in "datacenter_name" with "Just a datacenter"
	And I fill in "datacenter_location" with "Brussels"
	And I fill in "datacenter_comment" with "Some comment"
	And I press "Save"
	And I should see "Just a datacenter"	
