## Welcome! 

This is Lauren Kaye's repository for the Analytics Engineering intensive at CoRise.

**Weekly stakeholder Q&A can be found in the analyses folder.**


## Content covered

During project kickoff, I am provided with raw tables containing ecommerce data for a store 'greenery'.

Week 1 involved:
- **staging tables** with light transformations of our choosing using snowflake and dbt
- **yml files** for sources, models, and the dbt_project overall
- **snapshot model** for the orders table to track order status updates over time.
- **analyses** containing common business user questions and answers

Week 2 involved:
- **marts** folder with subdirectories for Core, Marketing and Product teams
- **fact** and **dim** models of our choosing based on business questions posed to us
- **tests** for our models

Week 3+4 involved:
- **macro** written to auto-generate rather than hardcode sql
- **post-hook** used to set role permissions
- **packages** installed and used (dbt-utils & codegen)
- **exposure** added to document potential upstream dependancies

Current state of the DAG:

<img width="1267" alt="Screen Shot 2022-10-21 at 1 20 14 PM" src="https://user-images.githubusercontent.com/109819898/197359094-80c462eb-7db3-4dd5-918b-7b2afac30c96.png">
