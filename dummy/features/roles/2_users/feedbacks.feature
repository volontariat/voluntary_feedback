@javascript
Feature: Manage feedbacks

  Background:
       
    Given a user named "user"
    And I log in as "user"
    
  Scenario: Create, edit and destroy feedbacks
    Given a community
    When I go to the community page
    And I click the new feedback link
    And I fill in "Title" with "Dummy feedback"
    And I fill in "Text" with "Dummy"
    And I press "Create Feedback"
    #Then I should see an alert telling me that "Successfully saved feedback."
    And I should not see "No feedbacks found." 
    And I should see "Dummy feedback"
    When I click the edit link of the first feedback
    And I fill in "Title" with "Dummy feedback2"
    And I press "Update Feedback"
    #Then I should see an alert telling me that "Successfully saved feedback."
    And I should see "Dummy feedback2"
    When I click the remove link of the first feedback
    And I confirm the following alert
    Then I should see "No feedbacks found."