Given /^I am a user_with_acces$/ do
    Given %{a user_with_acces exists}
  And %{I am on the root page}
  Then %{I fill in "user_email" with "info@openminds.be"}
  And %{I fill in "user_password" with "123456"}
  And %{I press "Sign in"}
end
Given /^I am an admin$/ do
    Given %{an admin exists}
  And %{I am on the root page}
  Then %{I fill in "user_email" with "admin@openminds.be"}
  And %{I fill in "user_password" with "123456"}
  And %{I press "Sign in"}
end