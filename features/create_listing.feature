Feature: display list of furniture sorted by different criteria

  As a furniture buyer
  So that I can quickly browse listed furniture based on my preferences
  I want to see furniture sorted by price or post date

Background: furniture have been added to database

  Given the following furniture items exist:
  | name                                       | location                  | purchase_date    |
  | Mission Oak II Queen Bookcase Storage Bed  | 96th & Broadway           | 10-Oct-2019      |
  | Electric Kettle, Brentwood                 | 114th & Broadway          | 5-Dec-2020       |
  And I am on the InstaFurniture home page
  Then 2 seed furniture should exist

Scenario: have all attributes for creation
  When I follow "Add Listing"
  Then I should see "Name"
  And I should see "Description"
  And I should see "Building has elevator"
  And I should see "Buyer must pick up"
  And I should see "Purchased On"