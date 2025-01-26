import { Page, expect, test } from '@playwright/test';
import { DataTable } from 'playwright-bdd';
import { Fixture, Step } from 'playwright-bdd/decorators';
import locators from '@support/locators.json';
import { QuestionAnswer } from '@support/types';

type QuestionType = 'number' | 'date' | 'radio';

type DateInputTable = {
  Day: string;
  Month: string;
  Year: string;
};

type NumberInputTable = {
  Input: string;
  Error: string;
};

type InvalidDateInputTable = DateInputTable & {
  'Expected Error Message': string;
};

/**
 * Removes search parameters from a URL string, this is used to remove errors
 * from the page, as they are populated via what's in the URL.
 *
 * @param {string} url - The URL to remove search parameters from
 * @returns {string} The URL with search parameters removed
 */
function removeSearchParams(url: string): string {
  const urlObject = new URL(url);
  urlObject.search = '';
  return urlObject.toString();
}

export
@Fixture('questionsPage')
class QuestionsPage {
  constructor(public page: Page) {}

  /**
   * Detects what the question type is on the page without explicitly passing it in.
   * There is assumption that there are only 3 question types, this can be scaled if
   * requirements change.
   */
  private async detectQuestionType(): Promise<QuestionType> {
    const textFields = this.page.locator(locators.inputField);
    const dateForm = this.page.locator(locators.dateInputField);
    const options = this.page.locator(locators.radioItem);

    const [textCount, dateCount, radioCount] = await Promise.all([
      textFields.count(),
      dateForm.count(),
      options.count(),
    ]);

    if (dateCount >= 3) return 'date';
    if (textCount === 1) return 'number';
    if (radioCount >= 2) return 'radio';

    throw new Error(
      'Could not detect question type - no matching input elements found on the page.',
    );
  }

  /**
   * Loops through a data table of inputs, performing actions and error checks for each entry
   * @template TDataTable - Type extending Record<string, string> for the data table entries
   * @param {TDataTable[]} dataTable - Array of data table entries to process
   * @param {(entry: TDataTable) => Promise<void>} inputAction - Action to perform for each input entry
   * @param {(entry: TDataTable) => Promise<void>} [errorCheckAction] - Optional error check action to perform
   */
  private loopThroughInputs = async <TDataTable extends Record<string, string>>(
    dataTable: TDataTable[],
    inputAction: (entry: TDataTable) => Promise<void>,
    errorCheckAction?: (entry: TDataTable) => Promise<void>,
  ) => {
    const errorElements = {
      title: this.page.locator(locators.errorTitle),
      summary: this.page.locator(locators.errorSummary),
    };
    const startingPageUrl = this.page.url();

    for (const entry of dataTable) {
      await test.step(`Validating Entry: ${JSON.stringify(entry)}`, async () => {
        // The ?next=1 search param is what triggers the error component.
        // Redirect back to a normal state for each try.
        const inputBaseUrl = removeSearchParams(this.page.url());

        await this.page.goto(inputBaseUrl);

        await expect(errorElements.title).not.toBeVisible();
        await expect(errorElements.summary).not.toBeVisible();

        await inputAction(entry);

        await this.pressContinue();

        if (errorCheckAction) {
          await errorCheckAction(entry);
        } else {
          await expect(errorElements.title).not.toBeVisible();
          await expect(errorElements.summary).not.toBeVisible();

          expect(this.page.url()).not.toBe(startingPageUrl);

          // Navigate back to start the next validation.
          await this.page.goto(startingPageUrl);
        }
      });
    }
  };

  /**
   * Clicks the continue button and verifies navigation by checking URL change
   */
  @Step(/^I click the continue button$/)
  async pressContinue() {
    const urlBefore = this.page.url();
    const startNowButton = this.page.locator(locators.button, { hasText: 'Continue' });
    await startNowButton.click();
    const urlAfter = this.page.url();

    expect(urlAfter).not.toBe(urlBefore);
  }

  /**
   * Selects a radio button option on the page
   * @param {string} option - The text label of the radio button to select
   */
  @Step(/^I select the "(.*)" option$/)
  async selectOption(option: string) {
    const optionElement = this.page.locator(locators.radioItem, { hasText: option });
    await optionElement.locator('input').click();
  }

  /**
   * Enters a valid date into the date input fields on the page
   * @param {string} date - The date string to parse and enter into the fields
   */
  @Step(/^I enter "(.*)" into the date field$/)
  async enterDate(date: string) {
    const parsedDate = new Date(date);
    const day = parsedDate.getDate();
    const month = parsedDate.getMonth() + 1;
    const year = parsedDate.getFullYear();

    const dayField = this.page.locator(locators.dateDayField);
    const monthField = this.page.locator(locators.dateMonthField);
    const yearField = this.page.locator(locators.dateYearField);

    await dayField.fill(day.toString());
    await monthField.fill(month.toString());
    await yearField.fill(year.toString());
  }

  /**
   * Enters a date that is offset from a given date by specified days and years
   *  - To plus days or years means to go further into the future.
   *  - To minus days or years means to go furhter into the past.
   *
   * @param {string} date - Base date to offset from
   * @param {'plus'|'minus'} dayOffsetType - Whether to add or subtract days
   * @param {string} dayOffsetAmount - Number of days to offset
   * @param {'plus'|'minus'} yearOffsetType - Whether to add or subtract years
   * @param {string} yearOffsetAmount - Number of years to offset
   */
  @Step(
    /^I enter a date that is "(.*)" (plus|minus) (\d{1,3}) day and (plus|minus) (\d{1,3}) year$/,
  )
  async enterDateWithinAYearOf(
    date: string,
    dayOffsetType: 'plus' | 'minus',
    dayOffsetAmount: string,
    yearOffsetType: 'plus' | 'minus',
    yearOffsetAmount: string,
  ) {
    const parsedDate = new Date(date);
    const dayOffsetNumber = parseInt(dayOffsetAmount);
    const yearOffsetNumber = parseInt(yearOffsetAmount);

    const dayOffsetMap = {
      plus: () => parsedDate.setDate(parsedDate.getDate() + dayOffsetNumber),
      minus: () => parsedDate.setDate(parsedDate.getDate() - dayOffsetNumber),
    };
    const yearOffsetMap = {
      plus: () => parsedDate.setFullYear(parsedDate.getFullYear() + yearOffsetNumber),
      minus: () => parsedDate.setFullYear(parsedDate.getFullYear() - yearOffsetNumber),
    };

    if (!(dayOffsetType in dayOffsetMap) || !(yearOffsetType in yearOffsetMap)) {
      throw new Error(`Invalid day offset type: ${dayOffsetType}`);
    }

    if (!(yearOffsetType in yearOffsetMap)) {
      throw new Error(`Invalid year offset type: ${yearOffsetType}`);
    }

    dayOffsetMap[dayOffsetType]();
    yearOffsetMap[yearOffsetType]();
    await this.enterDate(parsedDate.toString());
  }

  /**
   * Enters invalid date values and verifies error messages
   * @param {DataTable} dataTable - Table containing invalid date scenarios
   */
  @Step(/I enter the following invalid options in the date field there should be errors:/)
  async enterTableOfInvalidDates(dataTable: DataTable) {
    const invalidDateTable = dataTable.hashes() as InvalidDateInputTable[];
    const errorElements = {
      title: this.page.locator(locators.errorTitle),
      summary: this.page.locator(locators.errorSummary),
    };

    await this.loopThroughInputs(
      invalidDateTable,
      // The action to be done per entry in the data table.
      async ({ Day, Month, Year }) => {
        const dateFields = {
          day: this.page.locator(locators.dateDayField),
          month: this.page.locator(locators.dateMonthField),
          year: this.page.locator(locators.dateYearField),
        };

        await dateFields.day.fill(Day);
        await dateFields.month.fill(Month);
        await dateFields.year.fill(Year);
      },
      // Is expecting errors.
      async ({ 'Expected Error Message': errorMessage }) => {
        await expect(errorElements.title).toBeVisible();
        await expect(errorElements.summary).toBeVisible();

        const [errorTitleText, errorSummaryText] = await Promise.all([
          errorElements.title.textContent(),
          errorElements.summary.textContent(),
        ]);

        expect(errorTitleText?.trim()).toBe('There is a problem');
        expect(errorSummaryText?.trim()).toBe(errorMessage);
      },
    );
  }

  /**
   * Enters valid date values and verifies there are no error messages
   * @param {DataTable} dataTable - Table containing valid date scenarios
   */
  @Step(/I enter the following valid options in the date field there should be no errors:/)
  async enterTableOfValidDates(dataTable: DataTable) {
    const validDateTable = dataTable.hashes() as DateInputTable[];

    await this.loopThroughInputs(validDateTable, async ({ Day, Month, Year }) => {
      const dateFields = {
        day: this.page.locator(locators.dateDayField),
        month: this.page.locator(locators.dateMonthField),
        year: this.page.locator(locators.dateYearField),
      };

      await dateFields.day.fill(Day);
      await dateFields.month.fill(Month);
      await dateFields.year.fill(Year);
    });
  }

  @Step(/^I enter the following valid options in the number field there should be no errors:$/)
  async enterTableOfValidNumbers(dataTable: DataTable) {
    const validNumberTable = dataTable.hashes() as { Input: string }[];

    await this.loopThroughInputs(validNumberTable, async ({ Input }) => {
      await this.page.locator(locators.inputField).fill(Input);
    });
  }

  /**
   * Enters valid date values and verifies there are no error messages
   * @param {DataTable} dataTable - Table containing valid date scenarios
   */
  @Step(
    /^I enter the following invalid options in the number field there should be the following errors:$/,
  )
  async enterTableOfNumbers(dataTable: DataTable) {
    const validDateTable = dataTable.hashes() as NumberInputTable[];
    const errorElements = {
      title: this.page.locator(locators.errorTitle),
      summary: this.page.locator(locators.errorSummary),
    };

    await this.loopThroughInputs(
      validDateTable,
      async ({ Input }) => {
        await this.page.locator(locators.inputField).fill(Input);
      },
      async ({ Error: errorMessage }) => {
        await expect(errorElements.title).toBeVisible();
        await expect(errorElements.summary).toBeVisible();

        const [errorTitleText, errorSummaryText] = await Promise.all([
          errorElements.title.textContent(),
          errorElements.summary.textContent(),
        ]);

        expect(errorTitleText?.trim()).toBe('There is a problem');
        expect(errorSummaryText?.trim()).toBe(errorMessage);
      },
    );
  }

  /**
   * Enters a number into the input field on the page
   * @param {string} number - The number value to enter into the field
   */
  @Step(/^I enter "(.*)" into the number field$/)
  async enterNumber(number: string) {
    const inputElement = this.page.locator(locators.inputField);
    await inputElement.fill(number);
  }

  /**
   * Answers a question on the current page based on the provided questions array.
   * Detects the question type and enters the corresponding answer.
   * @param {QuestionAnswer[]} questions - Array of question/answer pairs to match against
   * @throws {Error} If question header text is not found or no matching question exists
   * @throws {Error} If question type cannot be determined
   */
  async answerQuestionOnPage(questions: QuestionAnswer[]) {
    const headerText = await this.getHeaderText();
    const associatedQuestion = this.findAssociatedQuestion(headerText, questions);
    await this.handleQuestionType(associatedQuestion);
    await this.pressContinue();
  }

  /**
   * Gets the header text from the current page.
   * @returns {Promise<string>} The text content of the page header
   * @throws {Error} If the header text cannot be found on the page
   */
  private async getHeaderText(): Promise<string> {
    const headerText = await this.page.locator(locators.pageHeader).textContent();
    if (!headerText) {
      throw new Error('Could not find question header text on the page.');
    }
    return headerText;
  }

  /**
   * Finds the associated question/answer pair based on the header text.
   * @param {string} headerText - The text from the page header to match against
   * @param {QuestionAnswer[]} questions - Array of question/answer pairs to search through
   * @returns {QuestionAnswer} The matching question/answer pair
   * @throws {Error} If no matching question is found in the data table
   */
  private findAssociatedQuestion(headerText: string, questions: QuestionAnswer[]): QuestionAnswer {
    const associatedQuestion = questions.find((qa) => headerText.includes(qa.Question));
    if (!associatedQuestion) {
      throw new Error(
        `Could not find a matching question in the gherkin question/answer data table for "${headerText}"`,
      );
    }
    return associatedQuestion;
  }

  /**
   * Handles different types of questions by detecting the question type and performing the appropriate action.
   * @param {QuestionAnswer} associatedQuestion - The question/answer pair to handle
   * @returns {Promise<void>}
   * @throws {Error} If the question type cannot be determined or is not supported
   */
  private async handleQuestionType(associatedQuestion: QuestionAnswer): Promise<void> {
    const questionType = await this.detectQuestionType();
    switch (questionType) {
      case 'number':
        await this.enterNumber(associatedQuestion.Answer);
        break;
      case 'date':
        await this.enterDate(associatedQuestion.Answer);
        break;
      case 'radio':
        await this.selectOption(associatedQuestion.Answer);
        break;
      default:
        throw new Error(`Unexpected error: did not get an associated question type.`);
    }
  }

  /**
   * Handles a series of questions asynchronously based on a data table input.
   * Processes up to 6 questions or until reaching the summary page.
   * @param {DataTable} dataTable - Table containing question and answer pairs
   * @returns {Promise<void>}
   */
  @Step(/^the calculator asks the following questions:$/)
  async handleQuestionsAsyncronously(dataTable: DataTable): Promise<void> {
    const questions = dataTable.hashes() as unknown as QuestionAnswer[];

    const maxQuestions = 6;
    for (let i = 0; i < maxQuestions; i++) {
      await this.answerQuestionOnPage(questions);

      const resultInfo = this.page.locator(locators.resultInfo);
      const onSummaryPage = await resultInfo.isVisible();

      // Break early and move onto the next stage.
      if (onSummaryPage) return;
    }
  }
}
