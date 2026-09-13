Feature: Breadcrumbs, redirects view and the redirect shortcut
  As a site editor
  I want breadcrumb schema markup, a redirects list and a redirect shortcut
  So that pages are indexed well and redirects are quick to manage

  Scenario: A page exposes the breadcrumb schema markup
    Given I am an anonymous user
    When I navigate to "/user/login"
    Then the JSON-LD on the page should contain a "BreadcrumbList" node

  Scenario: Webmaster sees the redirects admin view
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/config/search/redirect"
    Then I should see "There are no redirects yet."
     And I should see the button "Filter"

  Scenario: Content editor can open the redirects admin view
    Given I am a logged in user with the "Content editor" user
    When I navigate to "/admin/config/search/redirect"
    Then I should see "There are no redirects yet."

  Scenario: The default shortcut set has the redirect shortcut
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/config/user-interface/shortcut/manage/default/customize"
    Then I should see "Set up a redirect"
