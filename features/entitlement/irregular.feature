@Entitlement @IrregularHours
Feature: Holiday Entitlement Calculator Irregular Hours
  As an employee who works irregular hours
  I want to calculate holiday entitlement
  So that I can ensure compliance with working hours regulations

  # There are scenarios to consider here where the leave year start date is more than 10 months or so in the past.
  # I have raised the question with Hamza.

  Background:
    And I am on the start page
    When I click the start button
    Then I should be on the "Does the employee work irregular hours or for part of the year?" page
    When I select the "Yes" option
    And I click the continue button
    Then I should be on the "When does the leave year start" page

  Scenario Outline: Calculate holiday entitlement
    When I enter "<Leave Year Start Date>" into the date field
    And I click the continue button
    Then I should be on the "How many hours has the employee worked in the pay period" page
    When I enter "<Hours Work In Pay Period>" into the number field
    And I click the continue button
    Then I should be on the holiday entitlement summary
    And my entitlement should be calculated as "<Expected Entitlement>"

    Examples:
      | Leave Year Start Date | Hours Work In Pay Period | Expected Entitlement |
      | 01/01/2025            | 50                       | 6 hours              |

