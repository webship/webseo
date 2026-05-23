Feature: Schema.org Metatag bundled submodules
  As an admin user
  I want the Schema.org Metatag submodules to be available
  So that I can output JSON-LD for Articles, ItemList, WebPage and WebSite

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Schema.org submodules show up on the modules page
    When I navigate to "/admin/modules"
    Then I should see "Schema.org Metatag"
     And I should see "Schema.org Article"
     And I should see "Schema.org ItemList"
     And I should see "Schema.org WebPage"
     And I should see "Schema.org WebSite"
