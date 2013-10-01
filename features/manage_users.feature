Feature: managing users
  In order to allow people to use the application
  As an admin
  I want to manage user rights

  Background:
    Given I am using a regular browser

  Scenario: Signing up as a new user
    Given a user exists
    Given I am on the home page
    When I follow "Sign up"
    Then I should see "Email"
      And I should see "Password"
    When I fill in "user_email" with "testuser@openminds.be"
      And I fill in "user_password" with "123456"
      And I fill in "user_password_confirmation" with "123456"
      And I press "Sign up"
    Then I should see "You don't have sufficient rights to access the application."

  Scenario: Resetting a users password
    Given an admin exists
    And I am on the home page
    And I follow "Forgot your password"
    Then I should see "Forgot your password?"
    When I fill in "user_email" with "admin@openminds.be"
    And I press "Send me reset password instructions"
    Then I should see "You will receive an email with instructions about how to reset your password in a few minutes."

  Scenario: Giving a user working rights
    Given I am an admin
      And a user exists
      And I am on the home page
    Then I should see "Admin"
    When I follow "Admin"
    Then I should see "acces_denied"
    When I follow "Grant user rights"
    Then I should see "User can now use the application"

  Scenario: Giving a user admin rights
    Given I am an admin
      And a user exists
      And I am on the home page
    Then I should see "Admin"
    When I follow "Admin"
    Then I should see "acces_denied"
    When I follow "Grant admin rights"
    Then I should see "User is now admin"

  Scenario: Deleting a user
    Given I am an admin
      And a user exists
      And I am on the home page
    Then I should see "Admin"
    When I follow "Admin"
    Then I should see "acces_denied"
    When I follow "Delete user"
    Then I should see "User deleted"