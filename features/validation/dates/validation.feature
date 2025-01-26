@Validation @Date
Feature: Date Input Validation
  As an employee who works regular hours
  I want to be informed of incorrect data passed into the holiday calculator
  So that I can correctly answer the questions asked

  # These tests heavily rely on understanding the requirements for validation.
  # I have noticed in the scenario where an irregular houred employee is asked when their leave year start
  # The date input will accept any input for the year.
  # I'm going to make an assumption that this is intentional, and not a bug.

  @Valid
  Scenario Outline: Valid Date Values (Non Relative Dates)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following valid options in the date field there should be no errors:
      | Day   | Month | Year |
      | 02    | 02    | 2024 |
      | 00002 | 00002 | 2024 |
      | 2     | 2     | 2024 |
      | 03    | 11    | 1994 |
      | 3     | 03    | 2026 |

    Examples:
      | Question                           | Endpoint                                              |
      | When does the leave year start     | /y/irregular-hours-and-part-year                      |
      | What was the employment start date | /y/regular/days-worked-per-week/starting              |
      | What was the employment start date | /y/regular/days-worked-per-week/starting-and-leaving  |
      | What was the employment start date | /y/regular/hours-worked-per-week/starting             |
      | What was the employment start date | /y/regular/hours-worked-per-week/starting-and-leaving |
      | What was the employment start date | /y/regular/compressed-hours/starting                  |
      | What was the employment start date | /y/regular/compressed-hours/starting-and-leaving      |
      | What was the employment start date | /y/regular/annualised-hours/starting                  |
      | What was the employment start date | /y/regular/annualised-hours/starting-and-leaving      |
      | What was the employment start date | /y/regular/shift-worker/starting                      |
      | What was the employment start date | /y/regular/shift-worker/starting-and-leaving          |
      | What was the employment end date   | /y/regular/days-worked-per-week/leaving               |
      | What was the employment end date   | /y/regular/hours-worked-per-week/leaving              |
      | What was the employment end date   | /y/regular/compressed-hours/leaving                   |
      | What was the employment end date   | /y/regular/annualised-hours/leaving                   |
      | What was the employment end date   | /y/regular/shift-worker/leaving                       |

  @Valid
  Scenario Outline: Valid Date Values (Relative Dates Fields)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following valid options in the date field there should be no errors:
      | Day   | Month | Year |
      | 01    | 02    | 2024 |
      | 00001 | 00002 | 2024 |
      | 1     | 2     | 2024 |
      | 5     | 05    | 2023 |

    Examples:
      | Question                       | Endpoint                                             |
      | When does the leave year start | /y/regular/days-worked-per-week/starting/2024-02-02  |
      | When does the leave year start | /y/regular/hours-worked-per-week/starting/2024-02-02 |
      | When does the leave year start | /y/regular/compressed-hours/starting/2024-02-02      |
      | When does the leave year start | /y/regular/annualised-hours/starting/2024-02-02      |
      | When does the leave year start | /y/regular/shift-worker/starting/2024-02-02          |
      | When does the leave year start | /y/regular/days-worked-per-week/leaving/2024-03-03   |
      | When does the leave year start | /y/regular/hours-worked-per-week/leaving/2024-03-03  |
      | When does the leave year start | /y/regular/compressed-hours/leaving/2024-03-03       |
      | When does the leave year start | /y/regular/annualised-hours/leaving/2024-03-03       |
      | When does the leave year start | /y/regular/shift-worker/leaving/2024-03-03           |


  @Valid
  Scenario Outline: Valid Date Values (Relative Dates Starting And Leaving)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following valid options in the date field there should be no errors:
      | Day   | Month | Year |
      | 03    | 02    | 2024 |
      | 00003 | 00002 | 2024 |
      | 3     | 2     | 2024 |
      | 1     | 05    | 2024 |

    Examples:
      | Question                         | Endpoint                                                         |
      | What was the employment end date | /y/regular/days-worked-per-week/starting-and-leaving/2024-02-02  |
      | What was the employment end date | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02 |
      | What was the employment end date | /y/regular/compressed-hours/starting-and-leaving/2024-02-02      |
      | What was the employment end date | /y/regular/annualised-hours/starting-and-leaving/2024-02-02      |
      | What was the employment end date | /y/regular/shift-worker/starting-and-leaving/2024-02-02          |


  # Another case where requirements would clear this up, it seems any value will be accepted in the year field on irregular hours.
  # This one is most likely intentional as that data is probably not needed, but a full date input field would be a better UX.
  @Invalid
  Scenario Outline: Bug: Invalid Date Values
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the date field there should be errors:
      | Day       | Month  | Year                                   | Expected Error Message      |
      |           |        |                                        | Please answer this question |
      |           |        | 2000                                   | Please answer this question |
      | foo       | bar    | baz                                    | Please answer this question |
      | 9999      | 9999   | 99999                                  | Please answer this question |
      | 9999      | 02     | 2024                                   | Please answer this question |
      | 02        | 99999  | 2024                                   | Please answer this question |
      | i         | e      | ei                                     | Please answer this question |
      | undefined | 02     | 2025                                   | Please answer this question |
      | null      | 02     | 2025                                   | Please answer this question |
      | null      | 02     | 2025                                   | Please answer this question |
      | @!        | 02     | 2025                                   | Please answer this question |
      | 02        | �      | 2025                                   | Please answer this question |
      | 02        | \u202E | \u202E                                 | Please answer this question |
      | 02        | 02     | <script>alert('test')</script>         | Please answer this question |
      | 02        | \u202E | \u202E                                 | Please answer this question |
      | 02        | 02     | %20%3Cscript%3Ealert(1)%3C%2Fscript%3E | Please answer this question |
      | 02        | 02     | 999999999999999999999999999999         | Please answer this question |
      | 📙        | 📙     | 📙                                     | Please answer this question |

    Examples:
      | Question                       | Endpoint                         |
      | When does the leave year start | /y/irregular-hours-and-part-year |