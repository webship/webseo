Feature: Web SEO bundled modules are enabled
  As an admin user
  I want to verify that the Web SEO recipe enables every SEO module
  So that I know the recipe ran cleanly during install

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Modules report status page lists Web SEO as enabled
    Then the "webseo" module should be installed
     And the "metatag" module should be installed
     And the "pathauto" module should be installed
     And the "redirect" module should be installed
     And the "xmlsitemap" module should be installed
     And the "yoast_seo" module should be installed
     And the "google_analytics" module should be installed
     And the "google_tag" module should be installed
     And the "schema_metatag" module should be installed
