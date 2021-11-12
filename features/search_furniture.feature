Feature: display list of furniture items containing the keyword

  As a user of InstaFurniture, I should be able to quickly find the listings I want using keywords.
  I should be able to search by multiple keywords separated by spaces.
  So that I can purchase what I want within a very short period of time

  Background: furniture items have been added to database

    Given the following furniture items exist:
      | name                                      | description | location                                  | purchase_date | elevator_building | pickup_only |
      | Mission Oak II Queen Bookcase Storage Bed |             | 2549 Broadway, New York, NY 10025         | 10-Oct-2019   | true              | true        |
      | Electric Kettle, Brentwood                |             | 500 West 120th Street, New York, NY 10027 | 5-Dec-2020    | false             | false       |
      | Sofa bed with a pull out mattress         |             | 400 W 119th St, New York, NY 10027-7109   | 15-Jun-2018   | true              | true        |
      | Wayfair Bench with storage                |             | 103 West 107th Street, New York           | 20-Nov-2020   | true              | false       |
      | Desk and desk chair                       |             | 302 West 102nd Street, New York           | 19-Mar-2018   | false             | true        |

    And  I am on the InstaFurniture home page
    Then 5 furniture items should exist


  Scenario: searchinging "storage" returns 2 results
    Given I am on the InstaFurniture home page
    When I fill in "search-box" with "storage"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Mission Oak II Queen Bookcase Storage Bed"
    And I should see "Wayfair Bench with storage"
    And I should not see "Electric Kettle, Brentwood"
    And I should not see "Sofa bed with a pull out mattress"
    And I should not see "Desk and desk chair"

  Scenario: searching "bed" returns 2 results
    Given I am on the InstaFurniture home page
    When I fill in "search-box" with "bed"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Mission Oak II Queen Bookcase Storage Bed"
    And I should see "Sofa bed with a pull out mattress"
    And I should not see "Electric Kettle, Brentwood"
    And I should not see "Wayfair Bench with storage"
    And I should not see "Desk and desk chair"

  Scenario: searching "chair" returns 1 result
    Given I am on the InstaFurniture home page
    When I fill in "search-box" with "chair"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Desk and desk chair"
    And I should not see "Mission Oak II Queen Bookcase Storage Bed"
    And I should not see "Electric Kettle, Brentwood"
    And I should not see "Sofa bed with a pull out mattress"
    And I should not see "Wayfair Bench with storage"

  Scenario: searching "BeD" is case-insensitive and returns 2 results
    Given I am on the InstaFurniture home page
    When I fill in "search-box" with "BeD"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Mission Oak II Queen Bookcase Storage Bed"
    And I should see "Sofa bed with a pull out mattress"
    And I should not see "Electric Kettle, Brentwood"
    And I should not see "Wayfair Bench with storage"
    And I should not see "Desk and desk chair"

  Scenario: searching multiple keywords -- "bed chair" returns 3 results
    Given I am on the InstaFurniture home page
    When I fill in "search-box" with "bed chair"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Mission Oak II Queen Bookcase Storage Bed"
    And I should see "Sofa bed with a pull out mattress"
    And I should see "Desk and desk chair"
    And I should not see "Electric Kettle, Brentwood"
    And I should not see "Wayfair Bench with storage"

  Scenario: searching "lorem" returns no result
    Given I am on the InstaFurniture home page
    When I fill in "search-box" with "lorem"
    And I check the following tags: checkbox_pick_up
    And I check the following tags: checkbox_deliver
    And I uncheck the following tags: checkbox_elevator
    And I press "button_search"

    Then I should be on the InstaFurniture home page
    And I should see "Too bad! No furniture for you :("
    And I should not see "Desk and desk chair"
    And I should not see "Mission Oak II Queen Bookcase Storage Bed"
    And I should not see "Electric Kettle, Brentwood"
    And I should not see "Sofa bed with a pull out mattress"
    And I should not see "Wayfair Bench with storage"
