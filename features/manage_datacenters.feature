Feature: Manage datacenters
  In order to see my datacenters and their contents
  as a system admin
  I want to manage the datacenters
Background:
  Given I am a user_with_acces
  Given I am using a regular browser

Scenario: Add a datacenter
  Given I am on the new datacenter page
  And I fill in "datacenter_name" with "Just a datacenter"
  And I fill in "datacenter_location" with "Brussels"
  And I fill in "datacenter_comment" with "Some comment"
  And I press "Create Datacenter"
  Then I should see "Datacenter was successfully created."

Scenario: Delete a datacenter
  Given 10 datacenters exist
  Given I am on the home page
  When I follow "Destroy"
  Then I should see "Datacenter was successfully destroyed."

Scenario: Edit a datacenter
  Given 10 datacenters exist
  Given I am on the home page
  When I follow "Edit"
  And I fill in "datacenter_name" with "Just a datacenter"
  And I fill in "datacenter_location" with "Brussels"
  And I fill in "datacenter_comment" with "Some comment"
  And I press "Update Datacenter"
  Then I should see "Datacenter was successfully updated."
  And I should see "Just a datacenter"

Scenario: Trying to create an invalid datacenter
  Given I am on the new datacenter page
  And I press "Create Datacenter"
  Then I should see "Name can't be blank"

Scenario: Trying to make an existing datacenter invalid
  Given 10 datacenters exist
  Given I am on the home page
  When I follow "Edit"
  And I fill in "datacenter_name" with ""
  And I press "Update Datacenter"
  Then I should see "Name can't be blank"
