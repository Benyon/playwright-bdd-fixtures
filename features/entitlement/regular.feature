@Entitlement @RegularHours
Feature: Holiday Entitlement Calculator Regular Hours
  As an employee who works regular hours
  I want to calculate holiday entitlement
  So that I can ensure compliance with working hours regulations

  Background:
    Given I am on the start page
    And I click the start button
    And I should be on the "Does the employee work irregular hours or for part of the year?" page
    When I select the "No" option
    And I click the continue button
    Then I should be on the "Is the holiday entitlement based on" page

  @DaysWorkedPerWeek
  Scenario Outline: Days Worked Per Week
    Given my entitlement is based on "days worked per week"
    And I select the "days worked per week" option
    And I click the continue button
    And I should be on the "Do you want to work out holiday" page
    When the calculator asks the following questions:
      | Question                           | Answer             |
      | Do you want to work out holiday    | <Entitlement Type> |
      | Number of days worked per week     | <Days Worked>      |
      | What was the employment start date | <Start Date>       |
      | What was the employment end date   | <End Date>         |
      | When does the leave year start     | <Holiday Year>     |
    Then I should be on the holiday entitlement summary
    And my entitlement should be calculated as "<Expected Entitlement>"

    Examples:
      | Entitlement Type                                               | Days Worked | Start Date | End Date   | Holiday Year | Expected Entitlement |
      | for a full leave year                                          | 5           | -          | -          | -            | 28 days              |
      | for a full leave year                                          | 2           | -          | -          | -            | 11.2 days            |
      | for someone starting part way through a leave year             | 3           | 02/02/2024 | -          | 01/01/2024   | 15.5 days            |
      | for someone leaving part way through a leave year              | 4           | 02/02/2024 | 03/03/2024 | 01/01/2024   | 3.9 days             |
      | for someone starting and leaving part way through a leave year | 2           | 02/02/2024 | 03/03/2024 | -            | 1 days               |

  @HoursWorkedPerWeek
  Scenario Outline: Hours Worked Per Week
    Given my entitlement is based on "hours worked per week"
    And I select the "hours worked per week" option
    And I click the continue button
    And I should be on the "Do you want to work out holiday" page
    When the calculator asks the following questions:
      | Question                           | Answer             |
      | Do you want to work out holiday    | <Entitlement Type> |
      | Number of hours worked per week    | <Hours Worked>     |
      | Number of days worked per week     | <Days Worked>      |
      | What was the employment start date | <Start Date>       |
      | What was the employment end date   | <End Date>         |
      | When does the leave year start     | <Holiday Year>     |
    Then I should be on the holiday entitlement summary
    And my entitlement should be calculated as "<Expected Entitlement>"

    Examples:
      | Entitlement Type                                               | Hours Worked | Days Worked | Start Date | End Date   | Holiday Year | Expected Entitlement |
      | for a full leave year                                          | 40           | 5           | -          | -          | -            | 224 hours            |
      | for a full leave year                                          | 25           | 3           | -          | -          | -            | 140 hours            |
      | for someone starting part way through a leave year             | 38           | 5           | 02/02/2024 | -          | 01/01/2024   | 197.6 hours          |
      | for someone leaving part way through a leave year              | 37           | 5           | 02/02/2024 | 03/03/2024 | 01/01/2024   | 35.7 hours           |
      | for someone starting and leaving part way through a leave year | 40           | 4           | 02/02/2024 | 03/03/2024 | -            | 19 hours             |

  @CompressedHours
  Scenario Outline: Compressed Hours
    Given my entitlement is based on "compressed hours"
    And I select the "compressed hours" option
    And I click the continue button
    And I should be on the "Do you want to work out holiday" page
    When the calculator asks the following questions:
      | Question                           | Answer             |
      | Do you want to work out holiday    | <Entitlement Type> |
      | Number of hours worked per week    | <Hours Worked>     |
      | Number of days worked per week     | <Days Worked>      |
      | What was the employment start date | <Start Date>       |
      | What was the employment end date   | <End Date>         |
      | When does the leave year start     | <Holiday Year>     |
    Then I should be on the holiday entitlement summary
    And my entitlement should be calculated as "<Expected Entitlement>" otherwise "<Each Day Otherwise>"

    Examples:
      | Entitlement Type                                               | Hours Worked | Days Worked | Start Date | End Date   | Holiday Year | Expected Entitlement     | Each Day Otherwise     |
      | for a full leave year                                          | 40           | 5           | -          | -          | -            | 224 hours and 0 minutes  | 8 hours and 0 minutes  |
      | for a full leave year                                          | 25           | 3           | -          | -          | -            | 140 hours and 0 minutes  | 8 hours and 20 minutes |
      | for someone starting part way through a leave year             | 38           | 5           | 02/02/2024 | -          | 01/01/2024   | 197 hours and 36 minutes | 7 hours and 36 minutes |
      | for someone leaving part way through a leave year              | 37           | 5           | 02/02/2024 | 03/03/2024 | 01/01/2024   | 35 hours and 42 minutes  | 7 hours and 24 minutes |
      | for someone starting and leaving part way through a leave year | 40           | 4           | 02/02/2024 | 03/03/2024 | -            | 19 hours and 0 minutes   | 10 hours and 0 minutes |

  @AnnualisedHours
  Scenario Outline: Annualised Hours
    Given my entitlement is based on "annualised hours"
    And I select the "annualised hours" option
    And I click the continue button
    And I should be on the "Do you want to work out holiday" page
    When the calculator asks the following questions:
      | Question                           | Answer             |
      | Do you want to work out holiday    | <Entitlement Type> |
      | What was the employment start date | <Start Date>       |
      | What was the employment end date   | <End Date>         |
      | When does the leave year start     | <Holiday Year>     |
    Then I should be on the holiday entitlement summary
    And my entitlement should be calculated as "<Expected Entitlement>"

    Examples:
      | Entitlement Type                                               | Start Date | End Date   | Holiday Year | Expected Entitlement |
      | for a full leave year                                          | -          | -          | -            | 5.6 weeks            |
      | for a full leave year                                          | -          | -          | -            | 5.6 weeks            |
      | for someone starting part way through a leave year             | 02/02/2024 | -          | 01/01/2024   | 5.14 weeks           |
      | for someone leaving part way through a leave year              | 02/02/2024 | 03/03/2024 | 01/01/2024   | 0.97 weeks           |
      | for someone starting and leaving part way through a leave year | 02/02/2024 | 03/03/2024 | -            | 0.48 weeks           |

  @Shifts
  Scenario Outline: Shifts
    Given my entitlement is based on "shifts"
    And I select the "shifts" option
    And I click the continue button
    And I should be on the "Do you want to calculate the holiday" page
    When the calculator asks the following questions:
      | Question                                         | Answer               |
      | Do you want to calculate the holiday             | <Entitlement Type>   |
      | What was the employment start date               | <Start Date>         |
      | What was the employment end date                 | <End Date>           |
      | How many hours in each shift                     | <Shift Hours>        |
      | How many shifts will be worked per shift pattern | <Shifts per Pattern> |
      | How many days in the shift pattern               | <Days In Pattern>    |
      | When does the leave year start?                  | <Holiday Year>       |

    Then I should be on the holiday entitlement summary
    And my entitlement should be calculated as "<Expected Entitlement> for the year. Each shift being <Shift Hours> hours."

    Examples:
      | Entitlement Type                                               | Start Date | End Date   | Holiday Year | Shift Hours | Shifts per Pattern | Days In Pattern | Expected Entitlement |
      | for a full leave year                                          | -          | -          | -            | 6.0         | 5                  | 9               | 21.8 shifts          |
      | for a full leave year                                          | -          | -          | -            | 7.0         | 5                  | 10              | 19.6 shifts          |
      | for someone starting part way through a leave year             | 02/02/2024 | -          | 01/01/2024   | 5.0         | 5                  | 5               | 26 shifts            |
      | for someone leaving part way through a leave year              | 02/02/2024 | 03/03/2024 | 01/01/2024   | 12.0        | 5                  | 6               | 4.82 shifts          |
      | for someone starting and leaving part way through a leave year | 02/02/2024 | 03/03/2024 | -            | 5.0         | 5                  | 7               | 2.38 shifts          |