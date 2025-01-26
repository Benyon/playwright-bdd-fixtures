@Validation @Number @BoundaryTests
Feature: Number Input Boundary Validation
  As an employee who works regular hours
  I want to be informed of incorrect data passed into the holiday calculator
  So that I can correctly answer the questions asked

  # These tests heavily rely on understanding the requirements for validation.

  @Valid @HoursWorkedPerPayPeriod
  Scenario Outline: Valid Boundary Number Values (How many hours has the employee worked in the pay period)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following valid options in the number field there should be no errors:
      | Input |
      | 1     |
      | 1.1   |

    Examples:
      | Question                                                 | Endpoint                                    |
      | How many hours has the employee worked in the pay period | /y/irregular-hours-and-part-year/2025-02-02 |


  @Invalid @HoursWorkedPerPayPeriod
  Scenario Outline: Invalid Boundary Number Values (How many hours has the employee worked in the pay period)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input | Error                                                                                                                         |
      | 0     | You need to enter a number greater than 0. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |
      | -1    | You need to enter a number greater than 0. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |
      |       | Please answer this question                                                                                                   |

    Examples:
      | Question                                                 | Endpoint                                    |
      | How many hours has the employee worked in the pay period | /y/irregular-hours-and-part-year/2025-02-02 |


  @Valid @DaysInShiftPattern
  Scenario Outline: Valid Boundary Number Values (Number of hours worked per week)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following valid options in the number field there should be no errors:
      | Input    |
      | 0.5      |
      | 1        |
      | 1.5      |
      | 168      |
      | 167.9999 |
      | 168.0000 |

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

  # Bug: Input of 0.1 fails even though the description of the question suggests that 0.5 days is valid.
  @Invalid @DaysInShiftPattern @Bug
  Scenario Outline: Invalid Boundary Number Values (Number of hours worked per week)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input | Error                                                                                                                               |
      | 0     | Please enter at least .5 hours worked. Do not enter fractions. If you work half-hours, enter .5 for half. For example, 40.5         |
      | 169   | You can enter a maximum of 168 hours per week. Do not enter fractions. If you work half-hours, enter .5 for half. For example, 40.5 |
      | 0.1   | Please enter at least .5 hours worked. Do not enter fractions. If you work half-hours, enter .5 for half. For example, 40.5         |
      | 168.1 | You can enter a maximum of 168 hours per week. Do not enter fractions. If you work half-hours, enter .5 for half. For example, 40.5 |

    Examples:
      | Question                        | Endpoint                                                                    |
      | Number of hours worked per week | /y/regular/hours-worked-per-week/full-year/                                 |
      | Number of hours worked per week | /y/regular/hours-worked-per-week/starting/2024-02-02/2024-01-01             |
      | Number of hours worked per week | /y/regular/hours-worked-per-week/leaving/2024-03-03/2024-01-01              |
      | Number of hours worked per week | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03 |
      | Number of hours worked per week | /y/regular/compressed-hours/full-year                                       |
      | Number of hours worked per week | /y/regular/compressed-hours/starting/2024-02-02/2024-01-01                  |
      | Number of hours worked per week | /y/regular/compressed-hours/leaving/2024-03-03/2024-01-01                   |
      | Number of hours worked per week | /y/regular/compressed-hours/starting-and-leaving/2024-02-02/2024-03-03      |


  # Bug: Input of 0.5 fails even though the description of the question suggests that 0.5 days is valid.
  @Valid @DaysWorkedPerWeek @Bug
  Scenario Outline: Valid Boundary Number Values (Number of days worked per week) (Days Worked Per Week)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following valid options in the number field there should be no errors:
      | Input |
      | 1     |
      | 1.5   |
      | 7     |
      | 0.5   |

    Examples:
      | Question                       | Endpoint                                                                   |
      | Number of days worked per week | /y/regular/days-worked-per-week/full-year                                  |
      | Number of days worked per week | /y/regular/days-worked-per-week/starting/2024-02-02/2024-01-01             |
      | Number of days worked per week | /y/regular/days-worked-per-week/leaving/2024-03-03/2024-01-01              |
      | Number of days worked per week | /y/regular/days-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03 |


  @Invalid @DaysWorkedPerWeek
  Scenario Outline: Invalid Boundary Number Values (Number of days worked per week) (Days Worked Per Week)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input | Error                                                                    |
      | 0     | There are only 7 days in a week. Please check and enter a correct value. |
      | -1    | There are only 7 days in a week. Please check and enter a correct value. |
      | 8     | There are only 7 days in a week. Please check and enter a correct value. |
      | 7.5   | There are only 7 days in a week. Please check and enter a correct value. |

    Examples:
      | Question                       | Endpoint                                                                   |
      | Number of days worked per week | /y/regular/days-worked-per-week/full-year                                  |
      | Number of days worked per week | /y/regular/days-worked-per-week/starting/2024-02-02/2024-01-01             |
      | Number of days worked per week | /y/regular/days-worked-per-week/leaving/2024-03-03/2024-01-01              |
      | Number of days worked per week | /y/regular/days-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03 |


  @Valid @DaysWorkedPerWeek @AlternativeFlow
  Scenario Outline: Valid Boundary Number Values (Number of days worked per week) (Hours Worked Average)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following valid options in the number field there should be no errors:
      | Input                        |
      | <Valid Days In Hours Worked> |

    Examples:
      | Question                       | Endpoint                                                                         | Hours Worked Per Week | Valid Days In Hours Worked |
      | Number of days worked per week | /y/regular/hours-worked-per-week/full-year/24.0                                  | 24                    | 1                          |
      | Number of days worked per week | /y/regular/hours-worked-per-week/starting/2024-02-02/2024-01-01/48.0             | 48                    | 2                          |
      | Number of days worked per week | /y/regular/hours-worked-per-week/leaving/2024-03-03/2024-01-01/37.0              | 72                    | 3                          |
      | Number of days worked per week | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03/40.0 | 96                    | 4                          |
      | Number of days worked per week | /y/regular/compressed-hours/full-year/40.0                                       | 120                   | 5                          |
      | Number of days worked per week | /y/regular/compressed-hours/starting/2024-02-02/2024-01-01/38.0                  | 144                   | 6                          |
      | Number of days worked per week | /y/regular/compressed-hours/leaving/2024-03-03/2024-01-01/37.0                   | 168                   | 7                          |
      | Number of days worked per week | /y/regular/compressed-hours/starting-and-leaving/2024-02-02/2024-03-03/40.0      | 24                    | 2                          |


  @Invalid @DaysWorkedPerWeek @AlternativeFlow
  Scenario Outline: Invalid Boundary Number Values (Number of days worked per week) (Hours Worked Average)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input                          | Error                                                                    |
      | 0                              | There are only 7 days in a week. Please check and enter a correct value. |
      | <Invalid Days In Hours Worked> | There are only 24 hours per day. Please check and enter a correct value. |
      | 8                              | There are only 7 days in a week. Please check and enter a correct value. |

    Examples:
      | Question                       | Endpoint                                                                         | Hours Worked Per Week | Invalid Days In Hours Worked |
      | Number of days worked per week | /y/regular/hours-worked-per-week/full-year/48.0                                  | 48                    | 1                            |
      | Number of days worked per week | /y/regular/hours-worked-per-week/starting/2024-02-02/2024-01-01/48.0             | 48                    | 1                            |
      | Number of days worked per week | /y/regular/hours-worked-per-week/leaving/2024-03-03/2024-01-01/72.0              | 72                    | 2                            |
      | Number of days worked per week | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03/96.0 | 96                    | 3                            |
      | Number of days worked per week | /y/regular/compressed-hours/full-year/120.0                                      | 120                   | 4                            |
      | Number of days worked per week | /y/regular/compressed-hours/starting/2024-02-02/2024-01-01/144                   | 144                   | 5                            |
      | Number of days worked per week | /y/regular/compressed-hours/leaving/2024-03-03/2024-01-01/168.0                  | 168                   | 6                            |
      | Number of days worked per week | /y/regular/compressed-hours/starting-and-leaving/2024-02-02/2024-03-03/48.0      | 48                    | 1                            |


  @Valid @HoursPerShift
  Scenario Outline: Valid Boundary Number Values (How many hours in each shift)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following valid options in the number field there should be no errors:
      | Input |
      | 1     |
      | 0.1   |
      | 24    |
      | 23.99 |

    Examples:
      | Question                     | Endpoint                                                           |
      | How many hours in each shift | /y/regular/shift-worker/full-year                                  |
      | How many hours in each shift | /y/regular/shift-worker/starting/2024-02-02/2024-01-01             |
      | How many hours in each shift | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01              |
      | How many hours in each shift | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03 |


  @Invalid @HoursPerShift
  Scenario Outline: Invalid Boundary Number Values (How many hours in each shift)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input    | Error                                                                                                                           |
      | -1       | You need to enter a number greater than 0. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5   |
      | 0        | You need to enter a number greater than 0. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5   |
      | 24.00001 | 24 is the maximum number of hours per shift. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |
      | 25       | 24 is the maximum number of hours per shift. Do not enter fractions. If you work half-hours, enter .5 for half. For example 4.5 |

    Examples:
      | Question                     | Endpoint                                                           |
      | How many hours in each shift | /y/regular/shift-worker/full-year                                  |
      | How many hours in each shift | /y/regular/shift-worker/starting/2024-02-02/2024-01-01             |
      | How many hours in each shift | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01              |
      | How many hours in each shift | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03 |


  # Should there be validation here, seems like 500 shifts is exccessive, again, requirements would clear this up.
  @Valid @HoursPerShiftPattern
  Scenario Outline: Valid Boundary Number Values (How many shifts will be worked per shift pattern)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following valid options in the number field there should be no errors:
      | Input |
      | 1     |
      | 25    |
      | 500   |

    Examples:
      | Question                                         | Endpoint                                                               |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/full-year/6.0                                  |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/starting/2024-02-02/2024-01-01/5.0             |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01/12.0             |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03/5.0 |


  # The input of 0.5 should be an error, as a shifts pattern is an absolute value, however, is that error message acceptable?
  @Invalid @HoursPerShiftPattern
  Scenario Outline: Invalid Boundary Number Values (How many shifts will be worked per shift pattern)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input | Error                                     |
      | 0     | You need to enter a number greater than 0 |
      | -1    | You need to enter a number greater than 0 |
      | 0.5   | You need to enter a number greater than 0 |

    Examples:
      | Question                                         | Endpoint                                                               |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/full-year/6.0                                  |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/starting/2024-02-02/2024-01-01/5.0             |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01/12.0             |
      | How many shifts will be worked per shift pattern | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03/5.0 |


  @Valid @DaysInShiftPattern
  Scenario Outline: Valid Boundary Number Values (How many days in the shift pattern)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following valid options in the number field there should be no errors:
      | Input                |
      | <Shifts Per Pattern> |

    Examples:
      | Question                           | Endpoint                                                                 | Shifts Per Pattern |
      | How many days in the shift pattern | /y/regular/shift-worker/full-year/6.0/5                                  | 5                  |
      | How many days in the shift pattern | /y/regular/shift-worker/starting/2024-02-02/2024-01-01/5.0/5             | 6                  |
      | How many days in the shift pattern | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01/12.0/5             | 7                  |
      | How many days in the shift pattern | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03/5.0/5 | 8                  |


  # No upper limit on input, would normally raise this with somebody to cover ourselves.
  @Invalid @DaysInShiftPattern
  Scenario Outline: Invalid Boundary Number Values (How many days in the shift pattern)
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I am on the "<Question>" page
    Then I enter the following invalid options in the number field there should be the following errors:
      | Input                     | Error                                                                                                                                                                 |
      | <Invalid Days In Pattern> | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |
      | 0                         | You need to enter a number greater than or equal to the number of shifts you work. Do not enter fractions. If you work half-days, enter .5 for half. For example, 4.5 |

    Examples:
      | Question                           | Endpoint                                                                 | Invalid Days In Pattern |
      | How many days in the shift pattern | /y/regular/shift-worker/full-year/6.0/5                                  | 4                       |
      | How many days in the shift pattern | /y/regular/shift-worker/starting/2024-02-02/2024-01-01/5.0/6             | 5                       |
      | How many days in the shift pattern | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01/12.0/7             | 6                       |
      | How many days in the shift pattern | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03/5.0/8 | 7.9                     |

