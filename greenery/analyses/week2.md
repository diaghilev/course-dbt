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

Explain the mart models added?
**Work in Progress**
- **First, I want to ensure models are ultimately able to deliver metrics such as: AOV, total user/order/items sold, user return rate and conversion rate.**
- **For users, I layered in data that could help identify top/bottom users like total spend, # orders, # sessions**
- **For products, I layered in data to highlight performance including page views, daily orders, high traffic/low conversion**

# Paste an image of the DAG here

### PART 2

What assumptions are you making about each model?
- **Primary keys are not null and unique**
- **Item quantities are positive**
- **Order statuses and event types are consistent with a set of expected values**

 Did you find any bad data?
 How did you go about cleaning the data or adjusting assumptions/tests?

 ### PART 3

 Which orders changed from week 1 to 2?
- **The following order IDs changed:**
    - **914b8929-e04a-40f8-86ee-357f2be3a2a2**
    - **939767ac-357a-4bec-91f8-a7b25edd46c9**
    - **05202733-0e17-4726-97c2-0520c024ab85**