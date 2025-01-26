import { Page, expect } from '@playwright/test';
import { Fixture, Step } from 'playwright-bdd/decorators';
import locators from '@support/locators.json';

export
@Fixture('commonSteps')
class CommonSteps {
  constructor(public page: Page) {}

  /**
   * Navigates to the provided endpoint by appending it to the base URL.
   * If the endpoint starts with a '/', the '/' will be removed.
   *
   * @param endpoint - The URL endpoint, appended to the base URL.
   *                   Leading slashes are automatically stripped.
   */
  @Step(/^I navigate to the endpoint "(.*)"$/)
  async navigateToEndpoint(endpoint: string) {
    const strippedEndpoint = endpoint.startsWith('/') ? endpoint.slice(1) : endpoint;
    await this.page.goto(strippedEndpoint);
  }

  /**
   * Clicks the 'Start again' button on the page.
   * Locates and interacts with the button using the link locator that contains the text 'Start again'.
   */
  @Step(/^I click the start again button$/)
  async pressStartAgain() {
    const startAgainButton = this.page.locator(locators.link, { hasText: 'Start again' });
    await startAgainButton.click();
  }

  /**
   * Checks that there are no error messages visible on the page.
   * Verifies both the error summary and error title elements are not visible.
   */
  @Step(/^I should see no errors on the page$/)
  async assertNoErrors() {
    const errorTitle = this.page.locator(locators.errorTitle);
    const errorSummary = this.page.locator(locators.errorSummary);

    await expect(errorTitle).not.toBeVisible();
    await expect(errorSummary).not.toBeVisible();
  }

  /**
   * Checks for an error message on the page and verifies it matches the expected expression.
   * Validates both the error title is 'There is a problem' and the error summary matches
   * the provided regular expression pattern.
   *
   * @param errorMessage - Regular expression string pattern to match against the error summary text.
   */
  @Step(/^I should see an error on the page, to match the expression "(.*)"$/)
  async assertAnError(errorMessage: string) {
    const errorTitle = this.page.locator(locators.errorTitle);
    const errorSummary = this.page.locator(locators.errorSummary);

    await expect(errorTitle).toHaveText('There is a problem');

    const errorSummaryText = await errorSummary.textContent();
    expect(errorSummaryText?.trim()).toMatch(new RegExp(errorMessage));
  }

  /**
   * Checks the main content body h1 headers content.
   * We are truly blessed with how accessible the gov website is, all header are h1.
   * Allows for both should be and am on the page for better readability
   *
   * @param pageName Expected header on page.
   */
  @Step(/^I (should be|am) on the "(.*)" page$/)
  async onCorrectPage(_ignored: string, pageName: string) {
    const pageHeaderText = await this.page.locator(locators.pageHeader).textContent();
    expect(pageHeaderText).toContain(pageName);
  }

  /**
   * Asserts that the url ends with the provided endpoint.
   *
   * @param endpoint Url endpoint expected.
   */
  @Step(/^the url endpoint should be "(.*)"$/)
  urlShouldBe(endpoint: string) {
    const urlEndsWithEndpoint = this.page.url().endsWith(endpoint);
    expect(urlEndsWithEndpoint).toBeTruthy();

    // TODO: Could use a URL() constructor and assert the endpoint property.
  }

  /**
   * Confirms the presence or absence of the 'Start again' button.
   *
   * @param {'to be' | 'not to be'} buttonPresence - that is the question:
   *  whether 'tis nobler in the mind to suffer,
   *  the slings and arrows of outrageous fortune,
   *  or to take arms against a sea of troubles
   *  and by opposing end them... to be, or not to be... get it?
   *
   *  Whether to assert visibility or not.
   */
  @Step(/^start again button ((to be)|(not to be)) present$/)
  async assertNoStartAgainButton(buttonPresence: 'to be' | 'not to be') {
    const startAgain = this.page.locator(locators.link, { hasText: 'Start again' });

    if (buttonPresence === 'to be') {
      await expect(startAgain).toBeVisible();
    }
    if (buttonPresence === 'not to be') {
      await expect(startAgain).not.toBeVisible();
    }
  }
}
