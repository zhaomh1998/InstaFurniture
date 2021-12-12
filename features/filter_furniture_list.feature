Feature: display list of furniture items filtered by <buyer_must_pickup, seller_can_deliver, building_has_elevator>

  As a student just arrive the campus, I have to go through the pain of moving in the new apartment.
  Buying new furniture is expensive given that we only use them for one or two years, but for used ones,
  it’s difficult to find someone we trust on craigslist or facebook marketplace.

  Thus I want to have access to a list of second-hard furniture that caters to my needs and is close to
  my neighborhood or campus. I want to efficiently view where they are, and
  whether I have to pick up, and if the building has elevator, so that I can get settled down
  with minimum effort and cost.


  Background: furniture items have been added to database

    Given database is seeded
    Then 11 furniture items should exist
    And 4 users should exist


  Scenario: restrict to furniture items with elevator_building
    Given User logged in
    And I am on the InstaFurniture home page
    When I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I check the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "IKEA Side Table"
    And I should not see "Ikea Desk"

  Scenario: restrict to furniture items with pickup_only
    Given User logged in
    And I am on the InstaFurniture home page
    When I check the following tags: checkbox_pick_up
    And I uncheck the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "IKEA Sofa"
    And I should not see "Used Office Chair"

  Scenario: restrict to furniture items with deliver
    Given User logged in
    And I am on the InstaFurniture home page
    When I uncheck the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Used Office Chair"
    And I should not see "IKEA Sofa"

  Scenario: restrict to furniture items with pick up and elevator building
    Given User logged in
    And I am on the InstaFurniture home page
    When I check the following tags: checkbox_pick_up
    And I uncheck the following tags: checkbox_deliver
    And I check the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Aeron Chair Herman Miller Size B"
    And I should not see "Ikea Desk"

  Scenario: filter my listings
    Given User logged in as 1
    And I am on the InstaFurniture home page
    And I follow "My Listings"

    Then I should be on the InstaFurniture home page
    And 3 furniture cards should be displayed
    And I should see "IKEA Side Table"
    And I should see "Small Desk for Home Office"
    And I should see "Haugsvär Ikea Mattress"
