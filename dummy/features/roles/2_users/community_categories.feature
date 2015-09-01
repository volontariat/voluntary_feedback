@javascript
Feature: Manage community categories

  Background:
       
    Given a user named "user"
    And I log in as "user"
    
  Scenario: Create, edit and destroy communities
    Given a community assigned to me
    When I go to the new community category page
    And I fill in "Name" with "Dummy"
    And I press "Create Category"
    And wait 2 seconds
    Then I should see "Successfully saved category."
    And I should see "Dummy"
    When I go to the community category edit page
    And I fill in "Name" with "Dummy2"
    And I press "Update Category"
    And wait 2 seconds
    Then I should see "Successfully saved category."
    And I should see "Dummy2"
    When I go to the community categories page
    And delete the first community category
    Then I should see "No categories found."