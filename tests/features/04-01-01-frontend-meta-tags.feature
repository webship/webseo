Feature: Front-end meta tags rendered by Metatag
  As a search engine
  I want the front page to expose standard SEO meta tags
  So that the site is correctly indexed

  Scenario: Anonymous visitor sees canonical and shortlink in head
    Given I am an anonymous user
    When I navigate to "/"
    Then the page link rel "canonical" should exist
     And the page link rel "shortlink" should exist

  Scenario: Anonymous visitor sees a Generator meta tag
    Given I am an anonymous user
    When I navigate to "/"
    Then the page meta "name" "Generator" should exist
