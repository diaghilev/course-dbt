Welcome! This is Lauren Kaye's personal repository for the course Analytics Engineering with dbt at CoRise.

**Weekly stakeholder Q&A can be found in the analyses folder.**

Kickoff: I am provided us with tables (orders, users, events, promos, products, order_items) stored on a postgres database.

Week 1 involved:
- **staging tables** with light transformations of our choosing using snowflake and dbt
- **yml files** for sources, models, and the dbt_project overall
- **snapshot model** for the orders table to track order status updates over time.
- **analyses** containing common business user questions and answers

Week 2 involved:
- **marts** folder with subdirectories for Core, Marketing and Product teams
- **fact** and **dim** models of our choosing based on business questions posed to us
- **tests** for our models

Week 3 involved:
- **macro** written to auto-generate rather than hardcode sql
- **post-hook** used to set role permissions
- **packages** installed and used