Feature: Real-time SEO (Yoast) admin pages
  As an admin user
  I want to manage Yoast Real-time SEO
  So that editors get inline SEO analysis on the content forms

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the Yoast SEO config page
    When I navigate to "/admin/config/yoast_seo"
    Then I should see "Real-time SEO"
     And I should see the button "Save configuration"
