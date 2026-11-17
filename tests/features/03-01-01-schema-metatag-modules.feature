Feature: Schema.org Metatag bundled submodules
  As an admin user
  I want the Schema.org Metatag submodules to be available
  So that I can output JSON-LD for Articles, ItemList, WebPage and WebSite

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Schema.org submodules show up on the modules page
    Then the "schema_metatag" module should be installed
     And the "schema_article" module should be installed
     And the "schema_item_list" module should be installed
     And the "schema_web_page" module should be installed
     And the "schema_web_site" module should be installed
