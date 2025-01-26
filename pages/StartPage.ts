import { Page, expect } from '@playwright/test';
import { Fixture, Given, Step } from 'playwright-bdd/decorators';
import locators from '@support/locators.json';

export
@Fixture('startPage')
class StartPage {
  constructor(public page: Page) {}

  /**
   * Non-dynamic step, asserts the test is on the starting page.
   */
  @Given(/^I am on the start page$/)
  async goToPage() {
    await this.page.goto('/calculate-your-holiday-entitlement');
    const pageHeader = await this.page.locator(locators.pageHeader).textContent();
    const startButton = this.page.locator(locators.button, { hasText: 'Start now' });

    expect(pageHeader).toContain('Calculate holiday entitlement');
    await expect(startButton).toBeVisible();
  }

  /**
   * Non-dynamic step, clicks the start button on the start page.
   */
  @Step(/^I click the start button$/)
  async clickStartButton() {
    const startButton = this.page.locator(locators.button, { hasText: 'Start now' });
    await startButton.click();

    expect(this.page.url()).toMatch(/calculate-your-holiday-entitlement\/y$/);
  }
}
