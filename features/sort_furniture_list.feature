Feature: display list of furniture sorted by different criteria

  As a furniture buyer
  So that I can quickly browse listed furniture based on my preferences
  I want to see furniture sorted by price or post date

Background: furniture have been added to database

  Given the following furniture item exist:
  | name         |description | location         | price  | post_date    | label    |
  | Levo Monitor            | 1500   | 25-Nov-1992  | monitor  |
  | Apple Monitor           | 2000   | 25-Nov-1992  | monitor  |
  | Memory Mattress         | 800    | 26-Oct-1984  | mattress |
  And I am on the InstaFurniture home page
  Then 3 seed furniture should exist

Scenario: sort furniture alphabetically
  When I follow "name"
  Then I should see "Apple Monitor"
  And I should see "Levo Monitor"
  And I should see "Memory Mattress "


Scenario: sort furniture in increasing order of price
  When I follow "price"
  Then I should see "Memory Mattress  "
  And I should see "Levo Monitor"
  And I should see "Apple Monitor"
