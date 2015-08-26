@javascript
Feature: Manage communities

  Background:
       
    Given a user named "user"
    And an organization assigned to me
    And I log in as "user"
    
  Scenario: Create, edit and destroy communities
    And I go to the new community page
    And I fill in "Name" with "Dummy"
    And I fill in "Text" with "Text"
    And I press "Create Community"
    And wait 2 seconds
    Then I should see "Successfully saved community."
    And I should see "Dummy"
    When I go to the community edit page
    And I fill in "Name" with "Dummy2"
    And I press "Update Community"
    And wait 2 seconds
    Then I should see "Successfully saved community."
    And I should see "Dummy2"
    When I go to the communities page
    And delete the first community
    Then I should see "No communities found."