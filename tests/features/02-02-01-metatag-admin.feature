Feature: Metatag admin pages
  As an admin user
  I want to manage Metatag default tags
  So that the site exposes a consistent SEO metadata strategy

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the Metatag default list
    When I navigate to "/admin/config/search/metatag"
    Then I should see "Metatag"
     And I should see "Global"

  Scenario: Admin can edit the global Metatag defaults
    When I navigate to "/admin/config/search/metatag/global"
    Then I should see a "Page title" field
     And I should see a "Description" field
     And I should see the button "Save"
