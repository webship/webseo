Feature: Breadcrumbs and the redirects view
  As a site editor
  I want breadcrumb schema markup, and a redirects list
  So that pages are indexed well and redirects are quick to manage

  # The JSON-LD comes with the breadcrumb: the template of the breadcrumb block
  # (Easy Breadcrumb), or a Display Builder page layout that holds the
  # breadcrumb (Web SEO), once either way. The log in page needs to show it:
  # Olivero on the Standard profile does; the sign-in screen of the Webship
  # Starter template has no breadcrumb.
  @breadcrumb-block
  Scenario: A page exposes the breadcrumb schema markup
    Given I am an anonymous user
    When I navigate to "/user/login"
    Then the JSON-LD on the page should contain a "BreadcrumbList" node
     And the JSON-LD on the page should contain 1 "BreadcrumbList" node

  Scenario: Webmaster sees the redirects admin view
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/config/search/redirect"
    Then I should see "There are no redirects yet."
     And I should see the button "Filter"

  Scenario: Content editor can open the redirects admin view
    Given I am a logged in user with the "Content editor" user
    When I navigate to "/admin/config/search/redirect"
    Then I should see "There are no redirects yet."
