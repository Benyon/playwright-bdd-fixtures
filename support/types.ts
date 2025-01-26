export const entitlementOptions = [
  'days worked per week',
  'hours worked per week',
  'compressed hours',
  'annualised hours',
  'shifts',
] as const;

export type HolidayEntitlement = (typeof entitlementOptions)[number];

export interface QuestionAnswer {
  Question: string;
  Answer: string;
}
