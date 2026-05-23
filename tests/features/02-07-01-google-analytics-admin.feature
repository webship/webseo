Feature: Google Analytics admin pages
  As an admin user
  I want to configure the Google Analytics module
  So that the site reports pageviews to GA

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the Google Analytics settings
    When I navigate to "/admin/config/services/google-analytics"
    Then I should see "Google Analytics"
     And I should see the button "Save configuration"
