Feature: Login

  The website will support user login functionality.
  If the user does not login, the webpage will redirect the user to the login page.
  Only the user with edu email account will be permitted to logim.

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

  Scenario: User will be redirect to login page if not login
    Given I am on the InstaFurniture home page
    And User not logged in
    Then I should be on the Login page

    Given I am on the Listings page
    Then I should be on the Login page
    And Enable back test login bypass

  Scenario: User back to home page after login
    Given I am on the InstaFurniture home page
    And User logged in
    Then I should be on the InstaFurniture home page

    Given I am on the Listings page
    Then I should be on the Listings page
    And Enable back test login bypass