Feature: Redirect admin pages
  As an admin user
  I want to manage URL redirects
  So that old URLs can be redirected to new locations without 404s

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the redirect list
    When I navigate to "/admin/config/search/redirect"
    Then I should see "URL redirects"
     And I should see "Add redirect"

  Scenario: Admin can open the redirect settings tab
    When I navigate to "/admin/config/search/redirect/settings"
    Then I should see "Settings"
     And I should see the button "Save configuration"

  Scenario: Admin can open the 404 redirects log
    When I navigate to "/admin/config/search/redirect/404"
    Then I should see "Fix 404"

  Scenario: Admin can add a redirect from an old URL
    When I navigate to "/admin/config/search/redirect/add"
    Then I should see a "Path" field
     And I should see a "To" field
     And I should see the button "Save"
