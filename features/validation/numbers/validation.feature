@Validation @Number
Feature: Number Input Validation
  As an employee who works regular hours
  I want to be informed of incorrect data passed into the holiday calculator
  So that I can correctly answer the questions asked

  # These tests heavily rely on understanding the requirements for validation.


  @Invalid @HoursWorkedPerPayPeriod
  Scenario Outline: Valid Number Values (How many hours has the employee worked in the pay period)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input                                                        | Error                                                                                                                         |
      | -1                                                           | You need to enter a number greater than 0. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |
      | -10000000000000000000000000000000000000000000000000000000000 | You need to enter a number greater than 0. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |
      | 0                                                            | You need to enter a number greater than 0. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |
      | -0                                                           | You need to enter a number greater than 0. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |
      | a                                                            | Please answer this question                                                                                                   |
      |                                                              | Please answer this question                                                                                                   |
      | i                                                            | Please answer this question                                                                                                   |
      | undefined                                                    | Please answer this question                                                                                                   |
      | null                                                         | Please answer this question                                                                                                   |
      | @!                                                           | Please answer this question                                                                                                   |
      | <script>alert('test')</script>                               | Please answer this question                                                                                                   |
      | %20%3Cscript%3Ealert(1)%3C%2Fscript%3E                       | Please answer this question                                                                                                   |
      | \u202E                                                       | Please answer this question                                                                                                   |
      | Infinity                                                     | Please answer this question                                                                                                   |
      | 📙                                                           | Please answer this question                                                                                                   |

    Examples:
      | Question                                                 | Endpoint                                    |
      | How many hours has the employee worked in the pay period | /y/irregular-hours-and-part-year/2025-02-02 |


  @Invalid @DaysInShiftPattern
  Scenario Outline: Invalid Number Values (Number of hours worked per week)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input                                                        | Error                                                                                                                               |
      | -1                                                           | Please enter at least .5 hours worked. Do not enter fractions. If you work half-hours, enter .5 for half. For example, 40.5         |
      | -10000000000000000000000000000000000000000000000000000000000 | Please enter at least .5 hours worked. Do not enter fractions. If you work half-hours, enter .5 for half. For example, 40.5         |
      | 0                                                            | Please enter at least .5 hours worked. Do not enter fractions. If you work half-hours, enter .5 for half. For example, 40.5         |
      | -0                                                           | Please enter at least .5 hours worked. Do not enter fractions. If you work half-hours, enter .5 for half. For example, 40.5         |
      | 25345243243                                                  | You can enter a maximum of 168 hours per week. Do not enter fractions. If you work half-hours, enter .5 for half. For example, 40.5 |
      | 169                                                          | You can enter a maximum of 168 hours per week. Do not enter fractions. If you work half-hours, enter .5 for half. For example, 40.5 |
      | a                                                            | Please answer this question                                                                                                         |
      |                                                              | Please answer this question                                                                                                         |
      | i                                                            | Please answer this question                                                                                                         |
      | undefined                                                    | Please answer this question                                                                                                         |
      | null                                                         | Please answer this question                                                                                                         |
      | @!                                                           | Please answer this question                                                                                                         |
      | <script>alert('test')</script>                               | Please answer this question                                                                                                         |
      | %20%3Cscript%3Ealert(1)%3C%2Fscript%3E                       | Please answer this question                                                                                                         |
      | \u202E                                                       | Please answer this question                                                                                                         |
      | Infinity                                                     | Please answer this question                                                                                                         |
      | 📙                                                           | Please answer this question                                                                                                         |

    Examples:
      | Question                        | Endpoint                                                                    |
      | Number of hours worked per week | /y/regular/hours-worked-per-week/full-year                                  |
      | Number of hours worked per week | /y/regular/hours-worked-per-week/starting/2024-02-02/2024-01-01             |
      | Number of hours worked per week | /y/regular/hours-worked-per-week/leaving/2024-03-03/2024-01-01              |
      | Number of hours worked per week | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03 |
      | Number of hours worked per week | /y/regular/compressed-hours/full-year                                       |
      | Number of hours worked per week | /y/regular/compressed-hours/starting/2024-02-02/2024-01-01                  |
      | Number of hours worked per week | /y/regular/compressed-hours/leaving/2024-03-03/2024-01-01                   |
      | Number of hours worked per week | /y/regular/compressed-hours/starting-and-leaving/2024-02-02/2024-03-03      |


  # Entering 0.2 days shows an error, but it seems like a valid input.
  @Invalid @DaysWorkedPerWeek
  Scenario Outline: Valid Number Values (Number of days worked per week) (Days Worked Per Week)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input                                  | Error                                                                    |
      | -1                                     | There are only 7 days in a week. Please check and enter a correct value. |
      | 0                                      | There are only 7 days in a week. Please check and enter a correct value. |
      | 8                                      | There are only 7 days in a week. Please check and enter a correct value. |
      |                                        | There are only 7 days in a week. Please check and enter a correct value. |
      | javascript:eval('')                    | There are only 7 days in a week. Please check and enter a correct value. |
      | i                                      | There are only 7 days in a week. Please check and enter a correct value. |
      | undefined                              | There are only 7 days in a week. Please check and enter a correct value. |
      | null                                   | There are only 7 days in a week. Please check and enter a correct value. |
      | @!                                     | There are only 7 days in a week. Please check and enter a correct value. |
      | <script>alert('test')</script>         | There are only 7 days in a week. Please check and enter a correct value. |
      | %20%3Cscript%3Ealert(1)%3C%2Fscript%3E | There are only 7 days in a week. Please check and enter a correct value. |
      | \u202E                                 | There are only 7 days in a week. Please check and enter a correct value. |
      | Infinity                               | There are only 7 days in a week. Please check and enter a correct value. |
      | 📙                                     | There are only 7 days in a week. Please check and enter a correct value. |

    Examples:
      | Question                       | Endpoint                                                                   |
      | Number of days worked per week | /y/regular/days-worked-per-week/full-year                                  |
      | Number of days worked per week | /y/regular/days-worked-per-week/starting/2024-02-02/2024-01-01             |
      | Number of days worked per week | /y/regular/days-worked-per-week/leaving/2024-03-03/2024-01-01              |
      | Number of days worked per week | /y/regular/days-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03 |


  # Entering 0.2 days shows an error, but it seems like a valid input.
  @Invalid @DaysWorkedPerWeek @AlternativeFlow
  Scenario Outline: Valid Number Values (Number of days worked per week) (Hours Worked Average)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input                                  | Error                                                                    |
      | -1                                     | There are only 7 days in a week. Please check and enter a correct value. |
      | 0                                      | There are only 7 days in a week. Please check and enter a correct value. |
      | 8                                      | There are only 7 days in a week. Please check and enter a correct value. |
      | javascript:eval('')                    | Please answer this question                                              |
      | i                                      | Please answer this question                                              |
      |                                        | Please answer this question                                              |
      | undefined                              | Please answer this question                                              |
      | null                                   | Please answer this question                                              |
      | @!                                     | Please answer this question                                              |
      | <script>alert('test')</script>         | Please answer this question                                              |
      | %20%3Cscript%3Ealert(1)%3C%2Fscript%3E | Please answer this question                                              |
      | \u202E                                 | Please answer this question                                              |
      | Infinity                               | Please answer this question                                              |
      | 📙                                     | Please answer this question                                              |

    Examples:
      | Question                       | Endpoint                                                                         |
      | Number of days worked per week | /y/regular/hours-worked-per-week/full-year/40.0                                  |
      | Number of days worked per week | /y/regular/hours-worked-per-week/starting/2024-02-02/2024-01-01/38.0             |
      | Number of days worked per week | /y/regular/hours-worked-per-week/leaving/2024-03-03/2024-01-01/37.0              |
      | Number of days worked per week | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03/40.0 |
      | Number of days worked per week | /y/regular/compressed-hours/full-year/40.0                                       |
      | Number of days worked per week | /y/regular/compressed-hours/starting/2024-02-02/2024-01-01/38.0                  |
      | Number of days worked per week | /y/regular/compressed-hours/leaving/2024-03-03/2024-01-01/37.0                   |
      | Number of days worked per week | /y/regular/compressed-hours/starting-and-leaving/2024-02-02/2024-03-03/40.0      |


  @Invalid @HoursPerShift
  Scenario Outline: Valid Number Values (How many hours in each shift)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input                                  | Error                                                                                                                           |
      | -1                                     | You need to enter a number greater than 0. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5   |
      | 234523452435                           | 24 is the maximum number of hours per shift. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |
      | 25                                     | 24 is the maximum number of hours per shift. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |
      | 24.1                                   | 24 is the maximum number of hours per shift. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |
      | javascript:eval('')                    | Please answer this question                                                                                                     |
      | i                                      | Please answer this question                                                                                                     |
      |                                        | Please answer this question                                                                                                     |
      | undefined                              | Please answer this question                                                                                                     |
      | null                                   | Please answer this question                                                                                                     |
      | @!                                     | Please answer this question                                                                                                     |
      | <script>alert('test')</script>         | Please answer this question                                                                                                     |
      | %20%3Cscript%3Ealert(1)%3C%2Fscript%3E | Please answer this question                                                                                                     |
      | \u202E                                 | Please answer this question                                                                                                     |
      | Infinity                               | Please answer this question                                                                                                     |
      | 📙                                     | Please answer this question                                                                                                     |

    Examples:
      | Question                     | Endpoint                                                           |
      | How many hours in each shift | /y/regular/shift-worker/full-year                                  |
      | How many hours in each shift | /y/regular/shift-worker/starting/2024-02-02/2024-01-01             |
      | How many hours in each shift | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01              |
      | How many hours in each shift | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03 |


  # This input field allows extremely large numbers, is that per the requirements?
  @Invalid @HoursPerShiftPattern
  Scenario Outline: Valid Number Values (How many shifts will be worked per shift pattern)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input                                  | Error                                     |
      | -1                                     | You need to enter a number greater than 0 |
      | javascript:eval('')                    | You need to enter a number greater than 0 |
      | i                                      | You need to enter a number greater than 0 |
      | undefined                              | You need to enter a number greater than 0 |
      | null                                   | You need to enter a number greater than 0 |
      |                                        | You need to enter a number greater than 0 |
      | @!                                     | You need to enter a number greater than 0 |
      | <script>alert('test')</script>         | You need to enter a number greater than 0 |
      | %20%3Cscript%3Ealert(1)%3C%2Fscript%3E | You need to enter a number greater than 0 |
      | \u202E                                 | You need to enter a number greater than 0 |
      | Infinity                               | You need to enter a number greater than 0 |
      | 📙                                     | You need to enter a number greater than 0 |

    Examples:
      | Question                                         | Endpoint                                                               |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/full-year/6.0                                  |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/starting/2024-02-02/2024-01-01/5.0             |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01/12.0             |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03/5.0 |


  @Invalid @DaysInShiftPattern
  Scenario Outline: Valid Number Values (How many days in the shift pattern)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input                                  | Error                                                                                                                                                                 |
      | -1                                     | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | 0.1                                    | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | 1                                      | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | javascript:eval('')                    | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      |                                        | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | i                                      | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | undefined                              | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | null                                   | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | @!                                     | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | <script>alert('test')</script>         | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | %20%3Cscript%3Ealert(1)%3C%2Fscript%3E | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | \u202E                                 | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | Infinity                               | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | 📙                                     | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |

    Examples:
      | Question                           | Endpoint                                                                 |
      | How many days in the shift pattern | /y/regular/shift-worker/full-year/6.0/5                                  |
      | How many days in the shift pattern | /y/regular/shift-worker/starting/2024-02-02/2024-01-01/5.0/4             |
      | How many days in the shift pattern | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01/12.0/2             |
      | How many days in the shift pattern | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03/5.0/2 |

