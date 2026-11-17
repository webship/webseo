Feature: Access control for SEO admin pages
  As a site administrator
  I want SEO admin pages to be protected
  So that only privileged users can change SEO configuration

  Scenario: Anonymous user cannot access the metatag config
    Given I am an anonymous user
    Then I should be denied access to "/admin/config/search/metatag"

  Scenario: Anonymous user cannot access the redirect config
    Given I am an anonymous user
    Then I should be denied access to "/admin/config/search/redirect"

  Scenario: Anonymous user cannot access the xmlsitemap config
    Given I am an anonymous user
    Then I should be denied access to "/admin/config/search/xmlsitemap"

  Scenario: Anonymous user cannot access the Yoast SEO config
    Given I am an anonymous user
    Then I should be denied access to "/admin/config/yoast_seo"

  Scenario: Anonymous user cannot access the Google Analytics config
    Given I am an anonymous user
    Then I should be denied access to "/admin/config/services/google-analytics"

  Scenario: Authenticated user cannot access the metatag config
    Given I am a logged in user with the "Authenticated user" user
    Then I should be denied access to "/admin/config/search/metatag"
