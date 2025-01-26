import { Page, expect } from '@playwright/test';
import { entitlementOptions, HolidayEntitlement, QuestionAnswer } from '@support/types';
import { Fixture, Step } from 'playwright-bdd/decorators';
import locators from '@support/locators.json';
import { DataTable } from 'playwright-bdd';

type StringInterpolationFunction = (str: string, secondStr?: string) => string;

// Given what entitlement basis you choose, the output at the end is different.
const expectedSummaryStrings: Record<HolidayEntitlement | 'default', StringInterpolationFunction> =
  {
    'days worked per week': (str: string) => `The statutory holiday entitlement is ${str} holiday.`,
    'hours worked per week': (str: string) => `The statutory entitlement is ${str} holiday.`,
    'annualised hours': (str: string) => `The statutory holiday entitlement is ${str} holiday.`,
    'compressed hours': (str: string, secondStr?: string) =>
      `The statutory holiday entitlement is ${str} holiday for the year. ` +
      `Rather than taking a day’s holiday it’s ${secondStr} holiday for each day otherwise worked.`,
    shifts: (str: string) => `The statutory holiday entitlement is ${str}`,
    default: (str: string) => `The statutory entitlement for this pay period is ${str}`,
  };

export
@Fixture('summaryPage')
class SummaryPage {
  constructor(
    public readonly page: Page,
    private expectedSummary: StringInterpolationFunction = expectedSummaryStrings.default,
  ) {}

  /**
   * When provided an entitlement, stores the function that generates the expected summary string
   * @param { HolidayEntitlement } entitlement - Holiday entitlement type
   */
  @Step(/^my entitlement is based on "(.*)"$/)
  setEntitlement(entitlement: HolidayEntitlement) {
    const expectedSummary = expectedSummaryStrings[entitlement];
    if (!expectedSummary || typeof expectedSummary !== 'function') {
      throw new Error(
        `${entitlement} is not a valid entitlement type, options are: "${entitlementOptions.join(', ')}"`,
      );
    }
    this.expectedSummary = expectedSummary;
  }

  /**
   * Asserts that the user is on the holiday entitlement summary page.
   *
   * This function checks if the header, summary body, summary list, and "Start again" button
   * are visible and contain the expected content on the page.
   *
   * @todo Refactor, this should align to requirements.
   */
  @Step(/^I should be on the holiday entitlement summary$/)
  async shouldBeOnPage() {
    const header = this.page.locator(locators.pageHeader);
    const summaryBody = this.page.locator(locators.summaryBody);
    const summaryList = this.page.locator(locators.summaryListContainer);
    const startAgainButton = this.page.locator(locators.link, { hasText: 'Start again' });

    await expect(header).toContainText('Information based on your answers');
    await expect(summaryBody).toBeVisible();
    await expect(summaryList).toBeVisible();
    await expect(startAgainButton).toBeVisible();
  }

  /**
   * Verifies if the entitlement is calculated correctly based on the given value.
   *
   * @param {string} holidayEntitlement - The expected holiday entitlement value.
   * @param {string} [otherwise] - An optional alternate value to check for.
   *
   * @throws {Error} If the summary text is empty or does not contain the expected entitlement value.
   *
   * @step /^my entitlement should be calculated as "(.*?)"( otherwise "(.*)")?$/
   *
   * ```feature
   *  Given my entitlement should be calculated as "20 hours"
   *  Given my entitlement should be calculated as "20 hours" otherwise "8.5 hours"
   * ```
   */
  @Step(/^my entitlement should be calculated as "(.*?)"( otherwise "(.*)")?$/)
  async checkEntitlementIsCorrect(holidayEntitlement: string, otherwise?: string) {
    const summaryBody = this.page.locator(locators.summaryBody);
    const summaryText = await summaryBody.textContent();

    if (!summaryText || summaryText.length === 0) {
      throw new Error('Summary text did not exist or was empty.');
    }

    const expectedEntitlementString = this.expectedSummary(holidayEntitlement, otherwise);
    expect(summaryText.trim()).toContain(expectedEntitlementString);
  }

  /**
   * Asserts that the answers in the summary list match the expected values.
   *
   * This function clears out any blank answers from the provided data table and
   * checks if each expected answer is found in the summary list on the page.
   *
   * @param {DataTable} dataTable - The data table containing the expected answers.
   */
  @Step(/^the summary list answers contain:$/)
  async assertAnswersInSummaryList(dataTable: DataTable): Promise<void> {
    // Clear out any blank entries.
    const expectedAnswers = dataTable
      .hashes()
      .filter((h) => h.Answer !== '-') as unknown as QuestionAnswer[];

    // Extract the summary table from the page and assign to an object.
    const summaryListAnswers = await this.page.$$eval(
      locators.summaryListRow,
      (elements, locators) => {
        return elements.map((row) => {
          const key = row.querySelector(locators.summaryListKey)?.textContent?.trim() ?? '';
          const value = row.querySelector(locators.summaryListValue)?.textContent?.trim() ?? '';
          return { key, value };
        });
      },
      locators,
    );

    expectedAnswers.forEach((expectedItem) => {
      const answerFound = summaryListAnswers.find((f) => f.key.includes(expectedItem.Question));
      expect(
        answerFound,
        `
          Asserting Question: "${expectedItem.Question}"
          Expected: "${expectedItem.Answer}"
          Found: "${answerFound?.value ?? 'none'}"
        `,
      ).toBeTruthy();
    });
  }
}
