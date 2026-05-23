Feature: Google Tag Manager admin pages
  As an admin user
  I want to manage Google Tag containers
  So that GTM snippets are emitted on every page

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the Google Tag container list
    When I navigate to "/admin/config/services/google-tag"
    Then I should see "Google Tag"
