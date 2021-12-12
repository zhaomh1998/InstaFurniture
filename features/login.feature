Feature: Login

  The website will support user login functionality.
  If the user is not logged in, the webpage will redirect the user to the login page, on all pages except log in page.
  Only Columbia accounts will be permitted to log in.

  Background: furniture items have been added to database

    Given database is seeded
    Then 11 furniture items should exist
    And 4 users should exist


  Scenario: User will be redirected to login page from all pages if not logged in
    Given I go to the InstaFurniture home page
    And User not logged in
    Then I should be on the Login page

    Given I go to the Listings page
    Then I should be on the Login page


  Scenario: User back to home page after logging in
    Given User logged in as 1
    And I go to the InstaFurniture home page
    Then I should be on the InstaFurniture home page

    Given I go to the Listings page
    Then I should be on the Listings page
