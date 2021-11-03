Feature: display list of furniture sorted by different criteria

  As a furniture buyer
  So that I can quickly browse listed furniture based on my preferences
  I want to see furniture sorted by price or post date

Background: furniture have been added to database

  Given the following furniture item exist:
  | name                                       | location                  | purchase_date    |
  | Mission Oak II Queen Bookcase Storage Bed  | 96th & Broadway           | 10-Oct-2019      |
  | Electric Kettle, Brentwood                 | 114th & Broadway          | 5-Dec-2020       |
  And I am on the InstaFurniture home page
  Then 3 seed furniture should exist

Scenario: sort furniture alphabetically
  When I follow "name"
  Then I should see "Apple Monitor"
  And I should see "Levo Monitor"
  And I should see "Memory Mattress "

"""
Scenario: sort furniture in increasing order of price
  When I follow "price"
  Then I should see "Memory Mattress  "
  And I should see "Levo Monitor"
  And I should see "Apple Monitor"
"""