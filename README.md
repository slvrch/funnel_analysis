# Funnel Analysis

## Background Business

An e-commerce company wants to understand how users progress through its website from the Home page to Purchase Confirmation. Although the website receives a steady number of visitors, not all users complete the purchasing process.

To improve conversion performance, the business needs to identify where users leave the funnel, and understand customer navigation behavior before making optimization decisions.

## Business Question

  - How many sessions successfully reached each stage of the funnel?
  - At which stage do most users drop off?
  - Which page is the primary bottleneck in the customer journey?
  - Does customer behavior influence purchase completion?

## Business Objectives

- Measure website funnel performance from Home to Confirmation
- Identify the stage with the highest drop-off
- Analyze customer navigation behavior and exit patterns
- Provide data-driven recommendation to improve website conversion

## Data Understanding

Initial exploration was performed to understand the structure and quality of the dataset

The analysis included:

- Data type validation
- Missing value check
- Duplicate check
- Unique value exploration
- Page distribution
- Device distribution
- Country distribution
- Referral source distribution
- Timestamp validation

### Data Preparation

- Converted timestamp into Timestamp format
- Standardized page names
- Validated purchase flag
- Checked data consistency

### Feature Engineering

- visit_hour : hour of visit
- visit_date : visit date
- day_name : day of week
- step_number : page order within session
- total_step : total pages visited
- total_time_session : total session duration
- avg_time_session : average page duration
- landing_page : first visited page
- exit_page : last visited page
- session_purchase : purchase status per session
- funnel_step : funnel ordering
- funnel_stage : awareness → conversion
  
## Analysis 



## Conclusion



## Recommendation

