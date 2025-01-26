import { test as base } from 'playwright-bdd';
import { StartPage } from '@pages/StartPage';
import { CommonSteps } from '@pages/CommonSteps';
import { QuestionsPage } from '@pages/QuestionPage';
import { SummaryPage } from '@pages/SummaryPage';

export const test = base.extend<{
  commonSteps: CommonSteps;
  startPage: StartPage;
  questionsPage: QuestionsPage;
  summaryPage: SummaryPage;
}>({
  commonSteps: ({ page }, use) => use(new CommonSteps(page)),
  startPage: ({ page }, use) => use(new StartPage(page)),
  questionsPage: ({ page }, use) => use(new QuestionsPage(page)),
  summaryPage: ({ page }, use) => use(new SummaryPage(page)),
});
