Feature: Accepting a founding member invitation
  In order to participate in the founding of my group as an association
  As a member of the group
  I want to accept an invitation to become a founding member
  
  Background:
    Given the application is set up
    And an association has been created
    And the subdomain is the organisation's subdomain
  
  @javascript
  Scenario: Accepting a founding member invitation
    Given I have received an email inviting me to become a founding member
    When I follow the invitation link in the email
    Then screenshot the page
    And I fill in "Choose password" with "letmein"
    And I fill in "Confirm password" with "letmein"
    And I press "Continue"
    And I press "I accept these terms"
    Then I should be on the constitution page
