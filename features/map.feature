Feature: display Maps with markers on the map

  As user log into the website, the webpage will display a map and there will be markers on the map
  based on current listings.

  Background: furniture items have been added to database

    Given database is seeded
    Then 11 furniture items should exist
    And 4 users should exist

  Scenario: User sees map on the homepage
    Given User logged in
    And I am on the InstaFurniture home page
    Then I should see a map on the webpage

  Scenario: User sees markers on the map on homepage
    Given User logged in
    And I am on the InstaFurniture home page
    Then I should see different markers on the webpage

  Scenario: User sees map on the detail page
    Given User logged in
    And I am on the InstaFurniture home page
    And I click listing "listing_card_1"
    Then I should see "IKEA Side Table"
    And I should see a map on the webpage
