Feature: Web SEO bundled modules are enabled
  As an admin user
  I want to verify that the Web SEO recipe enables every SEO module
  So that I know the recipe ran cleanly during install

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Modules report status page lists Web SEO as enabled
    When I navigate to "/admin/modules"
    Then I should see "Web SEO"
     And I should see "Metatag"
     And I should see "Pathauto"
     And I should see "Redirect"
     And I should see "XML Sitemap"
     And I should see "Real-time SEO"
     And I should see "Google Analytics"
     And I should see "Google Tag"
     And I should see "Schema.org Metatag"
