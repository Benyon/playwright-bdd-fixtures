@Validation @Date @BoundaryTests
Feature: Date Input Boundary Validation
  As an employee who works regular hours
  I want to be informed of incorrect data passed into the holiday calculator
  So that I can correctly answer the questions asked

  # These tests heavily rely on understanding the requirements for validation
  # I have noticed in some date fields, you do not need to supply a year - My assumption is that this is intentional.
  #
  # Entering the same employment end date as your start date shows the message "Your end date can not be before your start date of 02 February 2024"
  # Probably not a 'bug' persae, however not a perfectly clear error message as it's not before the start date.
  # I am making the assumption that this is not a bug and just bad copy.

  @Valid @LeaveYearStart
  Scenario Outline: Valid Boundary Date Values (Leave Year Start)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page

    When I enter a date that is "<Employment Start Date>" minus 1 day and minus 0 year
    When I click the continue button
    Then I should see no errors on the page

    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I enter a date that is "<Employment Start Date>" plus 1 day and minus 1 year
    Then I should see no errors on the page

    # Most likely a better way to do this, I'd be interested to know your suggestions.
    Examples:
      | Question                        | Endpoint                                             | Employment Start Date |
      | When does the leave year start? | /y/regular/days-worked-per-week/starting/2024-02-02  | 02 February 2024      |
      | When does the leave year start? | /y/regular/days-worked-per-week/leaving/03-03-2024   | 03 March 2024         |
      | When does the leave year start? | /y/regular/hours-worked-per-week/starting/2024-02-02 | 02 February 2024      |
      | When does the leave year start? | /y/regular/hours-worked-per-week/leaving/03-03-2024  | 03 March 2024         |
      | When does the leave year start? | /y/regular/compressed-hours/starting/2024-02-02      | 02 February 2024      |
      | When does the leave year start? | /y/regular/compressed-hours/leaving/03-03-2024       | 03 March 2024         |
      | When does the leave year start? | /y/regular/annualised-hours/starting/2024-02-02      | 02 February 2024      |
      | When does the leave year start? | /y/regular/annualised-hours/leaving/03-03-2024       | 03 March 2024         |
      | When does the leave year start? | /y/regular/shift-worker/starting/2024-02-02          | 02 February 2024      |
      | When does the leave year start? | /y/regular/shift-worker/leaving/03-03-2024           | 03 March 2024         |


  @Invalid @LeaveYearStart
  Scenario Outline: Invalid Boundary Date Values (Leave Year Start)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page

    Given I enter "<Employment Start Date>" into the date field
    When I click the continue button
    Then I should see an error on the page, to match the expression "Your leave year start date must be earlier than your employment (start|end) date of <Employment Start Date>."

    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I enter a date that is "<Employment Start Date>" plus 0 day and minus 1 year
    When I click the continue button
    Then I should see an error on the page, to match the expression "Your employment (start|end) date of <Employment Start Date> must be within 1 year of the leave year start date."

    Examples:
      | Question                        | Endpoint                                             | Employment Start Date |
      | When does the leave year start? | /y/regular/days-worked-per-week/starting/2024-02-02  | 02 February 2024      |
      | When does the leave year start? | /y/regular/days-worked-per-week/leaving/2024-03-03   | 03 March 2024         |
      | When does the leave year start? | /y/regular/hours-worked-per-week/starting/2024-02-02 | 02 February 2024      |
      | When does the leave year start? | /y/regular/hours-worked-per-week/leaving/2024-03-03  | 03 March 2024         |
      | When does the leave year start? | /y/regular/compressed-hours/starting/2024-02-02      | 02 February 2024      |
      | When does the leave year start? | /y/regular/annualised-hours/starting/2024-02-02      | 02 February 2024      |
      | When does the leave year start? | /y/regular/annualised-hours/leaving/2024-03-03       | 03 March 2024         |
      | When does the leave year start? | /y/regular/shift-worker/starting/2024-02-02          | 02 February 2024      |
      | When does the leave year start? | /y/regular/shift-worker/leaving/2024-03-03           | 03 March 2024         |


  @Valid @EmploymentEndDate
  Scenario Outline: Valid Boundary Date Values (Employment End Date)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page

    When I enter a date that is "<Employment Start Date>" plus 1 day and plus 0 year
    When I click the continue button
    Then I should see no errors on the page

    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I enter a date that is "<Employment Start Date>" minus 1 day and plus 1 year
    When I click the continue button
    Then I should see no errors on the page

    Examples:
      | Question                         | Endpoint                                                         | Employment Start Date |
      | What was the employment end date | /y/regular/days-worked-per-week/starting-and-leaving/2024-02-02  | 02 February 2024      |
      | What was the employment end date | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02 | 02 February 2024      |
      | What was the employment end date | /y/regular/compressed-hours/starting-and-leaving/2024-02-02      | 02 February 2024      |
      | What was the employment end date | /y/regular/annualised-hours/starting-and-leaving/2024-02-02      | 02 February 2024      |
      | What was the employment end date | /y/regular/shift-worker/starting-and-leaving/2024-02-02          | 02 February 2024      |


  @Invalid @EmploymentEndDate
  Scenario Outline: Invalid Boundary Date Values (Employment End Date)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page

    Given I enter "<Employment Start Date>" into the date field
    When I click the continue button
    Then I should see an error on the page, to match the expression "Your end date can not be before your start date of <Employment Start Date>."

    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I enter a date that is "<Employment Start Date>" plus 0 day and plus 1 year
    When I click the continue button
    Then I should see an error on the page, to match the expression "Your employment end date must be within 1 year of your start date of <Employment Start Date>."

    Examples:
      | Question                         | Endpoint                                                         | Employment Start Date |
      | What was the employment end date | /y/regular/days-worked-per-week/starting-and-leaving/2024-02-02  | 02 February 2024      |
      | What was the employment end date | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02 | 02 February 2024      |
      | What was the employment end date | /y/regular/compressed-hours/starting-and-leaving/2024-02-02      | 02 February 2024      |
      | What was the employment end date | /y/regular/annualised-hours/starting-and-leaving/2024-02-02      | 02 February 2024      |
      | What was the employment end date | /y/regular/shift-worker/starting-and-leaving/2024-02-02          | 02 February 2024      |