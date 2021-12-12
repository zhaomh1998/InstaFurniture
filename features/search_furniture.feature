Feature: display list of furniture items containing the keyword

  As a user of InstaFurniture, I should be able to quickly find the listings I want using keywords.
  I should be able to search by multiple keywords separated by spaces.
  So that I can find what I want within a very short period of time

  Background: furniture items have been added to database

    Given database is seeded
    Then 11 furniture items should exist
    And 4 users should exist


  Scenario: searching "table" returns 3 results
    Given User logged in
    And I am on the InstaFurniture home page
    When I fill in "search-box" with "table"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And 1 furniture cards should be displayed
    And I should see "IKEA Side Table"

  Scenario: searching "chair" returns 2 results
    Given User logged in
    And I am on the InstaFurniture home page
    When I fill in "search-box" with "chair"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And 3 furniture cards should be displayed
    And I should see "Aeron Chair Herman Miller Size B"
    And I should see "Used Office Chair"
    And I should see "Target office chair"

  Scenario: searching "BeD" is case-insensitive and returns 1 results
    Given User logged in
    And I am on the InstaFurniture home page
    When I fill in "search-box" with "BeD"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And 1 furniture cards should be displayed
    And I should see "MUJI Wooden Full Size Bed Frame"

  Scenario: searching multiple keywords -- "bed chair" returns 4 results
    Given User logged in
    And I am on the InstaFurniture home page
    When I fill in "search-box" with "bed chair"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And 4 furniture cards should be displayed
    And I should see "MUJI Wooden Full Size Bed Frame"
    And I should see "Aeron Chair Herman Miller Size B"
    And I should see "Used Office Chair"
    And I should see "Target office chair"

  Scenario: searching "lorem" returns no result
    Given User logged in
    And I am on the InstaFurniture home page
    When I fill in "search-box" with "lorem"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And 0 furniture cards should be displayed
    And I should see "Too bad! No furniture for you :("
