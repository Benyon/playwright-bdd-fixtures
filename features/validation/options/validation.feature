@Validation @Options
Feature: Options Input Validation
  As an employee who works regular hours
  I want to be informed of incorrect data passed into the holiday calculator
  So that I can correctly answer the questions asked

  @Invalid
  Scenario Outline: Validate Continuing Without Option Set
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    And I am on the "<Question>" page
    When I click the continue button
    Then I should see an error on the page, to match the expression "Please answer this question"

    Examples:
      | Question                                                       | Endpoint                         |
      | Does the employee work irregular hours or for part of the year | /y                               |
      | Is the holiday entitlement based on                            | /y/regular                       |
      | Do you want to work out holiday                                | /y/regular/days-worked-per-week  |
      | Do you want to work out holiday                                | /y/regular/hours-worked-per-week |
      | Do you want to work out holiday                                | /y/regular/annualised-hours      |
      | Do you want to work out holiday                                | /y/regular/compressed-hours      |
      | Do you want to calculate the holiday                           | /y/regular/shift-worker          |
