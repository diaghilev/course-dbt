## Stakeholder Questions + Answers

### PART 1

What is our user repeat rate? **79.83**
```
WITH users_cte AS (
    SELECT
        user_id,
        COUNT(distinct order_id) AS purchase_count
    FROM DEV_DB.DBT_HI.STG_ORDERS
    GROUP BY user_id
),
purchases_cte AS (
    SELECT
        SUM(CASE WHEN purchase_count = 1 THEN 1 ELSE 0 END) AS single_purchase,
        SUM(CASE WHEN purchase_count > 1 THEN 1 ELSE 0 END) AS multi_purchase
    FROM users_cte
)
SELECT 
    (multi_purchase/(multi_purchase+single_purchase))*100 AS user_repeat_rate
FROM purchases_cte;
```
What are good indicators of a user who will likely to purchase - and not purchase - again?
- **Promo usage**
- **Products in first order**
- **Session behavior**
- **Purchase amount**

### PART 2

What assumptions are you making about each model?
- **Primary keys are not null and unique**
- **Quantities and purchases are positive**

 Did you find any bad data?
 How did you go about cleaning the data or adjusting assumptions/tests?

 ### PART 3

 Which orders changed from week 1 to 2?