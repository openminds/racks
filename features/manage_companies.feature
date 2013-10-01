Feature: Manage Companies
  In order to see which company uses wich device
  as a system admin
  I want to manage the companies

Background:
  Given I am a user_with_acces
  Given I am using a regular browser

Scenario: Create a new company
  Given I am on the companies page
  When I follow "Add Company"
  When I fill in "company_name" with "new company name"
  And I fill in "company_comment" with "This is a valid company, altough validations aren't implemented yet"
  And I press "Add company"
  Then I should see "Company was successfully created."
  And I should see "new company name"

Scenario: Trying to create an invalid company
  Given I am on the companies page
  When I follow "Add Company"
  When I press "Add company"
  Then I should see "Name can't be blank"

Scenario: Edit an existing company
  Given 10 companies exist
  And I am on the companies page
  When I follow "Edit"
  When I fill in "company_comment" with "Administrative Software"
  And I fill in "company_name" with "Except"
  And I press "Save company"
  Then I should see "Company was successfully updated."
  And I should see "Administrative Software"

Scenario: trying to make an existing company invalid
  Given 10 companies exist
  And I am on the companies page
  When I follow "Edit"
  When I fill in "company_comment" with "Administrative Software"
  And I fill in "company_name" with ""
  And I press "Save company"
  Then I should see "Name can't be blank"

Scenario: Delete an existing company
  Given the following companies exist:
  | name     | comment     |
  | Scarlet  | ISPP      |
  | Except  | Maatwerk    |
  | Servaco  | Labo      |
  And I am on the companies page
  When I follow "Delete"
  Then I should not see "Except"
  And I should see "Company was successfully destroyed."