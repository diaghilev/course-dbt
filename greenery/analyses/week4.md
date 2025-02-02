## Stakeholder Questions + Answers

### Snapshots

The orders that were shipped this week are:
- **d1020671-7cdf-493c-b008-c48535415611**
- **aafb9fbd-56e1-4dcc-b6b2-a3fd91381bb6**
- **38c516e8-b23a-493a-8a5c-bf7b2b9ea995**

### Modeling Challenge

We can continuously **monitor the product funnel** with the following query:

```
SELECT
    SUM(CASE WHEN session_page_views > 0 THEN 1 ELSE 0 END)/COUNT(session_id)*100 AS view_conversion_rate,
    SUM(CASE WHEN session_add_to_carts > 0 THEN 1 ELSE 0 END)/COUNT(session_id)*100 AS add_conversion_rate,
    SUM(CASE WHEN session_checkouts > 0 THEN 1 ELSE 0 END)/COUNT(session_id)*100 AS checkout_conversion_rate
FROM DEV_DB.DBT_HI.INT_SESSIONS_AGG;
```

If our data was continuously updating, we might add a date field and make a fact_daily_funnel model to monitor improvements over time.

The **results** for this query, representing all the data we have, are as follows:

| View Conversion Rate  | Add Conversion Rate | Checkout Conversion Rate
| --------------- | --------------- | ------------- |
| 100  | 80.7958  | 62.4567 |

Note that there is a slightly **larger dropoff** between Page View > Add to Cart step than from Add to Cart > Checkout step. 

### Reflection

In sum, a project like this one using dbt offers some of the following benefits:
- Team-wide visibility into model lineage, meaning:
    - Understanding downstream implications of changes and updates
    - Understanding how a given metric or fact/dim table came to be via upstream models
- Analytics is handled more like software eng, meaning:
    - version control, code review
    - testing
    - documentation
- Simultaneously, analysts can handle more sophisticated pipeline building with SQL (and a little jinja)

### Current state of DAG
<img width="1617" alt="Screen Shot 2022-10-30 at 1 51 14 PM" src="https://user-images.githubusercontent.com/109819898/198900999-4a721fe3-47f2-4fe1-8801-298704859ef9.png">

