@StartAgain
Feature: Holiday Entitlement Calculator Start Again Button
  As an employee calculating my holiday entitlement
  I want to be able to start my calculator again
  So that I can re-fill in the questionnaire


  Scenario Outline: Start Again Button
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    When I click the start again button
    Then I should be on the "Calculate holiday entitlement" page
    And the url endpoint should be "/calculate-your-holiday-entitlement"
    And start again button not to be present

    Examples:
      | Endpoint                                                                             |
      | /y/regular                                                                           |
      | /y/irregular-hours-and-part-year                                                     |
      | /y/regular/days-worked-per-week                                                      |
      | /y/irregular-hours-and-part-year/2025-01-01                                          |
      | /y/regular/days-worked-per-week/full-year                                            |
      | /y/irregular-hours-and-part-year/2025-01-01/50.0                                     |
      | /y/regular/days-worked-per-week/full-year/5.0                                        |
      | /y/regular                                                                           |
      | /y/regular/days-worked-per-week                                                      |
      | /y/regular/days-worked-per-week/full-year                                            |
      | /y/regular/days-worked-per-week/full-year/2.0                                        |
      | /y/regular                                                                           |
      | /y/regular/days-worked-per-week                                                      |
      | /y/regular/days-worked-per-week/starting                                             |
      | /y/regular/days-worked-per-week/starting/2024-02-02                                  |
      | /y/regular/days-worked-per-week/starting/2024-02-02/2024-01-01                       |
      | /y/regular/days-worked-per-week/starting/2024-02-02/2024-01-01/3.0                   |
      | /y/regular                                                                           |
      | /y/regular/days-worked-per-week                                                      |
      | /y/regular/days-worked-per-week/leaving                                              |
      | /y/regular/days-worked-per-week/leaving/2024-03-03                                   |
      | /y/regular/days-worked-per-week/leaving/2024-03-03/2024-01-01                        |
      | /y/regular/days-worked-per-week/leaving/2024-03-03/2024-01-01/4.0                    |
      | /y/regular                                                                           |
      | /y/regular/days-worked-per-week                                                      |
      | /y/regular/days-worked-per-week/starting-and-leaving                                 |
      | /y/regular/days-worked-per-week/starting-and-leaving/2024-02-02                      |
      | /y/regular/days-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03           |
      | /y/regular/days-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03/2.0       |
      | /y/regular                                                                           |
      | /y/regular/hours-worked-per-week                                                     |
      | /y/regular/hours-worked-per-week/full-year                                           |
      | /y/regular/hours-worked-per-week/full-year/40.0                                      |
      | /y/regular/hours-worked-per-week/full-year/40.0/5.0                                  |
      | /y/regular                                                                           |
      | /y/regular/hours-worked-per-week                                                     |
      | /y/regular/hours-worked-per-week/full-year                                           |
      | /y/regular/hours-worked-per-week/full-year/25.0                                      |
      | /y/regular/hours-worked-per-week/full-year/25.0/3.0                                  |
      | /y/regular                                                                           |
      | /y/regular/hours-worked-per-week                                                     |
      | /y/regular/hours-worked-per-week/starting                                            |
      | /y/regular/hours-worked-per-week/starting/2024-02-02                                 |
      | /y/regular/hours-worked-per-week/starting/2024-02-02/2024-01-01                      |
      | /y/regular/hours-worked-per-week/starting/2024-02-02/2024-01-01/38.0                 |
      | /y/regular/hours-worked-per-week/starting/2024-02-02/2024-01-01/38.0/5.0             |
      | /y/regular                                                                           |
      | /y/regular/hours-worked-per-week                                                     |
      | /y/regular/hours-worked-per-week/leaving                                             |
      | /y/regular/hours-worked-per-week/leaving/2024-03-03                                  |
      | /y/regular/hours-worked-per-week/leaving/2024-03-03/2024-01-01                       |
      | /y/regular/hours-worked-per-week/leaving/2024-03-03/2024-01-01/37.0                  |
      | /y/regular/hours-worked-per-week/leaving/2024-03-03/2024-01-01/37.0/5.0              |
      | /y/regular                                                                           |
      | /y/regular/hours-worked-per-week                                                     |
      | /y/regular/hours-worked-per-week/starting-and-leaving                                |
      | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02                     |
      | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03          |
      | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03/40.0     |
      | /y/regular/hours-worked-per-week/starting-and-leaving/2024-02-02/2024-03-03/40.0/4.0 |
      | /y/regular                                                                           |
      | /y/regular/compressed-hours                                                          |
      | /y/regular/compressed-hours/full-year                                                |
      | /y/regular/compressed-hours/full-year/40.0                                           |
      | /y/regular/compressed-hours/full-year/40.0/5.0                                       |
      | /y/regular                                                                           |
      | /y/regular/compressed-hours                                                          |
      | /y/regular/compressed-hours/full-year                                                |
      | /y/regular/compressed-hours/full-year/25.0                                           |
      | /y/regular/compressed-hours/full-year/25.0/3.0                                       |
      | /y/regular                                                                           |
      | /y/regular/compressed-hours                                                          |
      | /y/regular/compressed-hours/starting                                                 |
      | /y/regular/compressed-hours/starting/2024-02-02                                      |
      | /y/regular/compressed-hours/starting/2024-02-02/2024-01-01                           |
      | /y/regular/compressed-hours/starting/2024-02-02/2024-01-01/38.0                      |
      | /y/regular/compressed-hours/starting/2024-02-02/2024-01-01/38.0/5.0                  |
      | /y/regular                                                                           |
      | /y/regular/compressed-hours                                                          |
      | /y/regular/compressed-hours/leaving                                                  |
      | /y/regular/compressed-hours/leaving/2024-03-03                                       |
      | /y/regular/compressed-hours/leaving/2024-03-03/2024-01-01                            |
      | /y/regular/compressed-hours/leaving/2024-03-03/2024-01-01/37.0                       |
      | /y/regular/compressed-hours/leaving/2024-03-03/2024-01-01/37.0/5.0                   |
      | /y/regular                                                                           |
      | /y/regular/compressed-hours                                                          |
      | /y/regular/compressed-hours/starting-and-leaving                                     |
      | /y/regular/compressed-hours/starting-and-leaving/2024-02-02                          |
      | /y/regular/compressed-hours/starting-and-leaving/2024-02-02/2024-03-03               |
      | /y/regular/compressed-hours/starting-and-leaving/2024-02-02/2024-03-03/40.0          |
      | /y/regular/compressed-hours/starting-and-leaving/2024-02-02/2024-03-03/40.0/4.0      |
      | /y/regular                                                                           |
      | /y/regular/annualised-hours                                                          |
      | /y/regular/annualised-hours/full-year                                                |
      | /y/regular                                                                           |
      | /y/regular/annualised-hours                                                          |
      | /y/regular/annualised-hours/full-year                                                |
      | /y/regular                                                                           |
      | /y/regular/annualised-hours                                                          |
      | /y/regular/annualised-hours/starting                                                 |
      | /y/regular/annualised-hours/starting/2024-02-02                                      |
      | /y/regular/annualised-hours/starting/2024-02-02/2024-01-01                           |
      | /y/regular                                                                           |
      | /y/regular/annualised-hours                                                          |
      | /y/regular/annualised-hours/leaving                                                  |
      | /y/regular/annualised-hours/leaving/2024-03-03                                       |
      | /y/regular/annualised-hours/leaving/2024-03-03/2024-01-01                            |
      | /y/regular                                                                           |
      | /y/regular/annualised-hours                                                          |
      | /y/regular/annualised-hours/starting-and-leaving                                     |
      | /y/regular/annualised-hours/starting-and-leaving/2024-02-02                          |
      | /y/regular/annualised-hours/starting-and-leaving/2024-02-02/2024-03-03               |
      | /y/regular                                                                           |
      | /y/regular/shift-worker                                                              |
      | /y/regular/shift-worker/full-year                                                    |
      | /y/regular/shift-worker/full-year/6.0                                                |
      | /y/regular/shift-worker/full-year/6.0/5                                              |
      | /y/regular/shift-worker/full-year/6.0/5/9.0                                          |
      | /y/regular                                                                           |
      | /y/regular/shift-worker                                                              |
      | /y/regular/shift-worker/full-year                                                    |
      | /y/regular/shift-worker/full-year/7.0                                                |
      | /y/regular/shift-worker/full-year/7.0/5                                              |
      | /y/regular/shift-worker/full-year/7.0/5/10.0                                         |
      | /y/regular                                                                           |
      | /y/regular/shift-worker                                                              |
      | /y/regular/shift-worker/starting                                                     |
      | /y/regular/shift-worker/starting/2024-02-02                                          |
      | /y/regular/shift-worker/starting/2024-02-02/2024-01-01                               |
      | /y/regular/shift-worker/starting/2024-02-02/2024-01-01/5.0                           |
      | /y/regular/shift-worker/starting/2024-02-02/2024-01-01/5.0/5                         |
      | /y/regular/shift-worker/starting/2024-02-02/2024-01-01/5.0/5/5.0                     |
      | /y/regular                                                                           |
      | /y/regular/shift-worker                                                              |
      | /y/regular/shift-worker/leaving                                                      |
      | /y/regular/shift-worker/leaving/2024-03-03                                           |
      | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01                                |
      | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01/12.0                           |
      | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01/12.0/5                         |
      | /y/regular/shift-worker/leaving/2024-03-03/2024-01-01/12.0/5/6.0                     |
      | /y/regular                                                                           |
      | /y/regular/shift-worker                                                              |
      | /y/regular/shift-worker/starting-and-leaving                                         |
      | /y/regular/shift-worker/starting-and-leaving/2024-02-02                              |
      | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03                   |
      | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03/5.0               |
      | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03/5.0/5             |
      | /y/regular/shift-worker/starting-and-leaving/2024-02-02/2024-03-03/5.0/5/7.0         |


  Scenario Outline: Start Again Button Presence
    Given I navigate to the endpoint "/calculate-your-holiday-entitlement/<Endpoint>"
    Then start again button not to be present

    Examples:
      | Endpoint                              |
      | /calculate-your-holiday-entitlement   |
      | /calculate-your-holiday-entitlement/y |
