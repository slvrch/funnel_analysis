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


<img width="822" height="390" alt="image" src="https://github.com/user-attachments/assets/0de8b529-e977-4b25-a54f-85a932fbf8d1" />

Key Insight:

- Only **20.20%** of website sessions successfully completed the purchasing journey, indicating that approximately **four out of five visitors** did not reach the confirmation stage.
- The website experienced a substantial decline in user progression from **Product Page to Cart**, where nearly **60% of visitors exited the funnel**. 



  <img width="857" height="439" alt="image" src="https://github.com/user-attachments/assets/d9831020-527b-40dc-b061-b37f7bb44fc1" />

Key Insight:

-  Nearly ** 6 out of every 10 users** who viewed a product ** did not continue to add it to their cart**, making this the weakest stage in the purchasing journey
-  Because almost **60% of users leave before adding a product to the cart**, improving the Product Page has the greatest potential to increase overall conversion



<img width="844" height="459" alt="image" src="https://github.com/user-attachments/assets/f1c154c0-e4d1-4607-ba39-630a9f15581e" />

Key Insight:

-  Product Page recorded **the highest exit rate (47.76%)**, indicating that nearly half of all user sessions ended immediately after users viewed product information. This suggests that users were not sufficiently encouraged to continue to the Add-to-Card stage



<img width="846" height="449" alt="image" src="https://github.com/user-attachments/assets/1ee3d0a1-2170-4c67-9403-e9ac549b4a94" />

Key Insight:

- Purchased users spend approximately **2.6 times longer** on the website than non-purchased users. This indicates that higher session engagement is associated with a greater likelihood of completing the purchase journey.


## Conclusion

The analysis successfully identified the key factors affecting website conversion. Although the website attracted a substantial number of visitors, only 20.20% completed the purchasing journey. The Product Page emerged as the primary bottleneck, evidenced by both the highest drop-off rate (59.89%) and exit rate (47.76%). Furthermore, purchasing users spent approximately 2.6 times longer on the website than non-purchasing users, suggesting that stronger customer engagement is associated with successful conversions. Overall, the findings indicate that optimizing the Product Page and encouraging deeper user engagement are likely to have the greatest impact on improving conversion performance.


## Recommendation

- 
