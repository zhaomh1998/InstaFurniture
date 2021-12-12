Feature: Login

  The website will support user login functionality.
  If the user does not login, the webpage will redirect the user to the login page.
  Only the user with edu email account will be permitted to logim.

  Background: furniture items have been added to database

    Given database is seeded
    Then 11 furniture items should exist
    And 4 users should exist


  Scenario: User will be redirect to login page if not login
    Given I am on the InstaFurniture home page
    And User not logged in
    Then I should be on the Login page

    Given I am on the Listings page
    Then I should be on the Login page


  Scenario: User back to home page after login
    Given Log in as 1
    And I am on the InstaFurniture home page
    Then I should be on the InstaFurniture home page

    Given I am on the Listings page
    Then I should be on the Listings page