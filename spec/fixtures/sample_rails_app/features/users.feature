Feature: User Management
  Scenario: View all users
    Given I am on the users page
    When I visit the users index
    Then I should see a list of users
