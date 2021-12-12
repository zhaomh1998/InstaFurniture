Feature: Login

  The website will support user login functionality.
  If the user is not logged in, the webpage will redirect the user to the login page, on all pages except log in page.
  Only Columbia accounts will be permitted to log in.

  Background: furniture items have been added to database

    Given database is seeded
    Then 11 furniture items should exist
    And 4 users should exist


  Scenario: User will be redirected to login page from all pages if not logged in
    Given User not logged in

    Given I go to the InstaFurniture home page
    Then I should be on the Login page
    And I should see "Please log in with columbia.edu email"

    Given I go to the Listings page
    Then I should be on the Login page
    And I should see "Please log in with columbia.edu email"


    Given I go to the New page
    Then I should be on the Login page
    And I should see "Please log in with columbia.edu email"

    Given I view listing 1
    Then I should be on the Login page
    And I should see "Please log in with columbia.edu email"
    
    Given I create listing "listingName"
    Then I should be on the Login page
    And I should see "Please log in with columbia.edu email"

    Given I edit listing 1
    Then I should be on the Login page
    And I should see "Please log in with columbia.edu email"

    Given I submit edit to listing 1 renaming to "listingNewName"
    Then I should be on the Login page
    And I should see "Please log in with columbia.edu email"

    Given I delete listing 1
    Then I should be on the Login page
    And I should see "Please log in with columbia.edu email"


  Scenario: User sent to home page after logging in
    Given User logged in as 1
    And I go to the InstaFurniture home page
    Then I should be on the InstaFurniture home page

    Given I go to the Listings page
    Then I should be on the Listings page

  @MockLogInWithColumbia
  Scenario: User successful log in with columbia.edu email
    Given User logged in with OAuth
    Then I should be on the InstaFurniture home page
    And I can see "Columbia User" logged in

  @MockLogInWithTC
  Scenario: User successful log in with tc.columbia.edu email
    Given User logged in with OAuth
    Then I should be on the InstaFurniture home page
    And I can see "TC User" logged in

  @MockLogInWithBarnard
  Scenario: User successful log in with barnard.edu email
    Given User logged in with OAuth
    Then I should be on the InstaFurniture home page
    And I can see "Barnard User" logged in

  @MockLogInWithGmail
  Scenario: User cannot log in with gmail.com email
    Given User logged in with OAuth
    Then I should be on the Login page

  @MockLogInWithFakeColumbia
  Scenario: User cannot log in with fakecolumbia.edu email
    Given User logged in with OAuth
    Then I should be on the Login page

  @InvalidLogin
  Scenario: Invalid log ins are blocked and error shown to user
    Given User logged in with OAuth
    Then I should be on the Login page


  Scenario: Log out will return to login page
    Given User logged in
    Then I should be on the InstaFurniture home page
    Given I follow "Logout"
    Then I should be on the Login page
    And I should see "Successfully logged out"
