@javascript
Feature: Manage replies

  Background:
       
    Given a user named "user"
    And I log in as "user"
    
  Scenario: Create, edit and destroy replies
    Given a feedback
    When I go to the feedback page
    And I click the new reply link
    And I fill in "Text" with "Dummy reply"
    And I press "Create Reply"
    And I should not see "No replies found." 
    And I should see "Dummy reply"
    When I click the edit link of the first reply
    And I fill in "Text" with "Dummy reply2"
    And I press "Update Reply"
    And I should see "Dummy reply2"
    When I click the remove link of the first reply
    And I confirm the following alert
    Then I should see "No replies found."