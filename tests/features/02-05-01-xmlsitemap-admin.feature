Feature: XML Sitemap admin pages
  As an admin user
  I want to manage the XML sitemap
  So that search engines can crawl all important content

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the XML sitemap list
    When I navigate to "/admin/config/search/xmlsitemap"
    Then I should see "XML sitemap"

  Scenario: Admin can open the XML sitemap settings tab
    When I navigate to "/admin/config/search/xmlsitemap/settings"
    Then I should see "Settings"
     And I should see the button "Save configuration"

  Scenario: The sitemap.xml endpoint is publicly accessible
    Given I am an anonymous user
    Then the response status of "/sitemap.xml" should be 200
     And the response body of "/sitemap.xml" should contain "<urlset"
