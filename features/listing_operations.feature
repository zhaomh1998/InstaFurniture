Feature: listing operations

  As a furniture seller, I can quickly create listings filling in all key information I want to present to user.
  I can edit the information in my listings, and I cannot edit other's listings.

  Background: furniture items have been added to database

    Given database is seeded
    Then 11 furniture items should exist
    And 4 users should exist


  Scenario: have all attributes for creation
    Given User logged in as 1
    When I follow "Add Listing"
    Then I should be on the New page
    And I should see "Create New Listing"
    And I should see "Name"
    And I should see "Description"
    And I should see "Location"
    And I should see "Photo"
    And I should see "Phone Number"
    And I should see "Buyer Pays"
    And I should see "Purchased On"
    And I should see "Building has elevator"
    And I should see "Buyer must pick up"
    And I should see "Purchased On"

  Scenario: created listing shows up on home page
    Given User logged in as 1
    Then I should be on the InstaFurniture home page
    And I should not see "TestListing"
    When I follow "Add Listing"
    Then I should be on the New page
    And I should see "Create New Listing"

    When I fill in "Name" with "TestListing"
    And I press "Create Listing"
    Then I should be on the InstaFurniture home page
    And I should see "TestListing"

  Scenario: have all attributes for edit
    Given User logged in as 1
    When I click listing "listing_card_1"
    Then I should see "IKEA Side Table"
    And I should see "Edit"

    When I follow "Edit"
    Then I should see "Edit Listing"
    And I should see "Name"
    And I should see "Description"
    And I should see "Location"
    And I should see "Photo"
    And I should see "Phone Number"
    And I should see "Buyer Pays"
    And I should see "Purchased On"
    And I should see "Building has elevator"
    And I should see "Buyer must pick up"
    And I should see "Purchased On"

  Scenario: edited listing shows up on home page
    Given User logged in as 1
    Then I should be on the InstaFurniture home page
    And I should not see "TestListing1NewName"

    Given I click listing "listing_card_1"
    Then I should see "IKEA Side Table"
    And I should see "Edit"
    When I follow "Edit"
    And I fill in "Name" with "TestListing1NewName"
    And I press "Update Listing"
    Then I should see "TestListing1NewName was successfully updated."

    Given I go to the InstaFurniture home page
    Then I should see "TestListing1NewName"

  Scenario: cannot edit other's listing
    Given User logged in as 1
    When I click listing "listing_card_2"
    Then I should see "Ikea Desk"
    And I should not see "Edit"
    And I should see "Text"
    And I should see "Email"

    Given I edit listing 2
    Then I should see "Error: You are not allowed to edit someone else's listing!"

    Given I submit edit to listing 2 renaming to "listingNewName"
    Then I should see "Error: You are not allowed to edit someone else's listing!"

  Scenario: deleted listing disappear from home page
    Given User logged in as 1
    Then I should be on the InstaFurniture home page
    And I should see "Small Desk for Home Office"

    Given I click listing "listing_card_5"
    Then I should see "Small Desk for Home Office"
    And I should see "Delete"
    When I follow "Delete"
    Then I should see "Listing 'Small Desk for Home Office' deleted."

    Given I go to the InstaFurniture home page
    Then I should not see "Small Desk for Home Office"

  Scenario: cannot delete other's listing
    Given User logged in as 1
    When I click listing "listing_card_2"
    Then I should see "Ikea Desk"
    And I should not see "Delete"
    And I should see "Text"
    And I should see "Email"

    Given I delete listing 2
    Then I should see "Error: You are not allowed to delete someone else's listing!"
