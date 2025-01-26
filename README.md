# Playwright Solirius Technical

## Overview

This project demonstrates automated testing capabilities using Playwright with BDD (Behavior Driven Development) for the GOV.UK holiday entitlement calculator.

## Tech Stack

- Playwright
- TypeScript
- Cucumber (via playwright-bdd)
- HTML Reporter

## Project Structure

```bash
.
├── .vscode/                 # Contains settings to help with reading .feature files
├── features/                # Gherkin feature files
├── pages/                   # POM model, with steps embedded into the page files themselves
├── support/                 # Utility files, types and locators
├── playwright.config.ts     # Playwright configuration
├── eslint.config.mjs        # Linting rules to align to a common practice
└── prettier.config.mjs      # Formatter rules to align to a common practice
```

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/playwright-solirius-technical.git
   ```

2. Install the dependancies:

   ```bash
   cd playwright-solirius-technical
   npm install
   ```

## Running Tests

- Execute all tests:

  ```bash
  npm run test:run
  ```

- Open in UI mode:

  ```bash
  npm run test:open
  ```

## Test Reports

HTML reports are generated in cucumber-report/index.html  
Additional Playwright HTML report is also available

- To review the reports:

  ```bash
  npm run report
  ```

## Configuration

- Tests run in parallel with 4 workers by default (configurable in playwright.config.ts)
- Base URL points to gov.uk
- Screenshots and traces are enabled by default
- Cucumber reporter configured for detailed BDD reporting

## Framework Features

- **Parallel Execution**: Tests run concurrently with configurable workers
- **Screenshot Capture**: Automatic capture on test failure
- **Trace Viewer**: Full trace capture for debugging
- **Cross-browser Testing**: Support for Chromium, Firefox, and WebKit
- **Type Safety**: Full TypeScript implementation
- **BDD Integration**: Cucumber for behavior-driven development
- **Page Object Pattern**: Maintainable and reusable page interactions
- **Custom Helpers**: Utility functions for common operations
- **Best Practices Implemented** Following industry standards
- **BDD Patterns**: Clear, business-focused feature files
- **Data-Driven Testing**: Scenario outlines with examples
- **Page Encapsulation**: Separated page interactions
- **Clean Code**: ESLint and Prettier enforcement
- **Maintainable Selectors**: Centralized locator management
- **Error Handling**: Robust test stability
- **Documentation**: Comprehensive inline comments

## Potential Enhancements

- Refinement of user flows to reduce maintenance
- Encapsulate locators into the page objects as it scales up
- Gherkin-lint to enforce common practices
- Extrapolate page object model further for less complexit
- Test cases to be refactored to be more business driven, than logic driven.
- Reviewed scenarios tagged with @Bug
