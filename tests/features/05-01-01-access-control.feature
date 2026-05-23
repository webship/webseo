Feature: Access control for SEO admin pages
  As a site administrator
  I want SEO admin pages to be protected
  So that only privileged users can change SEO configuration

  Scenario: Anonymous user cannot access the metatag config
    Given I am an anonymous user
    When I navigate to "/admin/config/search/metatag"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the redirect config
    Given I am an anonymous user
    When I navigate to "/admin/config/search/redirect"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the xmlsitemap config
    Given I am an anonymous user
    When I navigate to "/admin/config/search/xmlsitemap"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the Yoast SEO config
    Given I am an anonymous user
    When I navigate to "/admin/config/yoast_seo"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the Google Analytics config
    Given I am an anonymous user
    When I navigate to "/admin/config/services/google-analytics"
    Then I should see "Access denied"

  Scenario: Authenticated user cannot access the metatag config
    Given I am a logged in user with the "Authenticated user" user
    When I navigate to "/admin/config/search/metatag"
    Then I should see "Access denied"
