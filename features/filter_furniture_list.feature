Feature: display list of furniture items filtered by customer rating
 
  As a student just arrive the campus, I have to go through the pain of moving in the new apartment, buying new furniture is expensive given that we only use them for one or two years, but for used ones, it’s difficult to find someone we trust on craigslist or facebook marketplace. 
  Thus I want to have access to a list of second-hard furniture that caters to my needs and is close to my neighborhood or campus.
  So that I can purchase them within a very short period of time

Background: furniture items have been added to database

  Given the following furniture items exist:
  | name                                       | description  | location   |   purchase_date  | elevator_building  | pickup_only |
  | Mission Oak II Queen Bookcase Storage Bed  |              | 96th & Broadway  | 10-Oct-2019 | true              | true       |
  | Electric Kettle, Brentwood                 |              | 114th & Broadway | 10-Oct-2019 | false             | false      |

  And  I am on the InstaFurniture home page
  Then 2 furniture items should exist


Scenario: restrict to furniture items with elevator_building
  Given I am on the InstaFurniture home page
  When I check the following tags: checkbox_pick_up
  And I check the following tags: checkbox_deliver
  And I check the following tags: checkbox_elevator
  And I press "button_search"

  Then I should be on the InstaFurniture home page
  And I should see "Mission Oak II Queen Bookcase Storage Bed"
  And I should not see "Electric Kettle, Brentwood"

  Scenario: restrict to furniture items with pickup_only
    Given I am on the InstaFurniture home page
    When I check the following tags: checkbox_pick_up
    And I uncheck the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Mission Oak II Queen Bookcase Storage Bed"
    And I should not see "Electric Kettle, Brentwood"

  Scenario: restrict to furniture items with deliver
    Given I am on the InstaFurniture home page
    When I uncheck the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Electric Kettle, Brentwood"
    And I should not see "Mission Oak II Queen Bookcase Storage Bed"

  Scenario: restrict to furniture items with pick up and elevator building
    Given I am on the InstaFurniture home page
    When I check the following tags: checkbox_pick_up
    And I uncheck the following tags: checkbox_deliver
    And I check the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Mission Oak II Queen Bookcase Storage Bed"
    And I should not see "Electric Kettle, Brentwood"
