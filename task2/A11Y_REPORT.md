# Accessibility Test Report

## Introduction

This report outlines the results of the accessibility test performed on Accesibility Chat Robot. The evaluation follows the Web Content Accessibility Guidelines (WCAG) 2.1 at AA.

## Summary

- **Test Date**: 26/01/2025
- **Tested Pages/Components**:
  - Accessibility Chat Robot
- **Compliance Status**: Full Compliance
- **Key Findings**:
  - 1 Critical Issues
  - 2 Serious Issues
  - 8 Moderate Issues

## Issues Identified

| **Issue**                                                  | **Number of Nodes** | **Location**                                                      | **Impact** | **Recommendation**                                                                                                              |
| ---------------------------------------------------------- | ------------------- | ----------------------------------------------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Documents must have \<title\> element to aid in navigation | 1                   | \<html\>                                                          | Critical   | Add a non empty \<title\> element                                                                                               |
| \<html\> element must have a lang attribute                | 1                   | \<html\>                                                          | Serious    | Add a lang attribute, such as "en-GB"                                                                                           |
| Images must have alternative text                          | 1                   | \<img class="contact-image" src="images/robot-3114245_1280.png"\> | Serious    | Add alt attribute, aria-label, aria-labelledby with a reference or title attribute                                              |
| Document should have atleast one main landmark             | 1                   | \<html\>                                                          | Moderate   | Use both HTML 5 and ARIA landmarks to ensure all content is contained within a navigational region.                             |
| Page should contain a level-one heading                    | 1                   | \<html\>                                                          | Moderate   | Main content should start with a h1 element.                                                                                    |
| All page content should be contained by landmarks          | 6                   | \<html\>                                                          | Moderate   | Ensure all content is contained within a landmark region, designated with HTML5 landmark elements and/or ARIA landmark regions. |

## Accessibility Checklist

| **Criteria**                | **Status** | **Notes**                            |
| --------------------------- | ---------- | ------------------------------------ |
| Keyboard Navigation         | ✅ Pass    | Fully navigable via keyboard.        |
| Contrast Ratio (4.5:1 min)  | ✅ Pass    | Passes for all colour-blind modes    |
| Screen Reader Compatibility | ❌ Fail    | Missing ARIA labels on key elements. |

## Tools Used

- Axe
- WCAG Contrast Checker

## Conclusion

The accessibility audit highlights areas for improvement, particularly screen reader labels. Recommended next steps include addressing critical issues and retesting.

This was tested at AA, however there was a failure at AAA for text size.

---
