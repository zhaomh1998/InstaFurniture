Feature: display list of furniture items filtered by customer rating
 
  As a student just arrive the campus, I have to go through the pain of moving in the new apartment, buying new furniture is expensive given that we only use them for one or two years, but for used ones, it’s difficult to find someone we trust on craigslist or facebook marketplace. 
  Thus I want to have access to a list of second-hard furniture that caters to my needs and is close to my neighborhood or campus.
  So that I can purchase them within a very short period of time

Background: furniture items have been added to database

  Given the following furniture items exist:
  | title                   | price  | post_date    |   label    |
  | Levo Monitor            | 1500   | 25-Nov-1992  |   monitor  |
  | Apple Monitor           | 2000   | 25-Nov-1992  |   monitor  | 
  | Memory Mattress         | 800    | 26-Oct-1984  |   mattress |

  And  I am on the InstaFurniture home page
  Then 3 furniture items should exist

Scenario: restrict to furniture items with monitor label
  Given I check the following labels: monitor
  And I uncheck the following labels: mattress
  When I press "Refresh"
  Then I should see "Levo Monitor"
  And I should see "Apple Monitor"
  # enter step(s) to ensure that other furniture items are not visible
  Then I should not see "Memory Mattress"

Scenario: all ratings selected
  Given I check the following labels: monitor, mattress
  Then I should see all the furniture items

