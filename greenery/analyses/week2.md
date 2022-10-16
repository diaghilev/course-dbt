## Stakeholder Questions + Answers

### PART 1

What is our user repeat rate? **79.83**
```
WITH purchase_count AS (
SELECT
    SUM(CASE WHEN total_orders = 1 THEN 1 ELSE 0 END) AS single_purchase,
    SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS multi_purchase
FROM DEV_DB.DBT_HI.DIM_USERS
)
SELECT
    (multi_purchase/(multi_purchase+single_purchase))*100 AS user_repeat_rate
FROM purchase_count
```
Theoretically, what are indicators of a user who is likely to purchase - or not purchase - again?
- **Session behavior such as time spent on site and 'add to cart' events.**
- **Products in first order. A product that exceeds expectations makes future purchases more likely. The reverse is also true.**
- **Promo usage. Degree of discounting on a first order may work for or against the business and should be analyzed.**

Explain the mart models added?
- **First, I consider end goals. We'll need to deliver metrics such as: AOV, user/order/items sold, session length**
- **Next, I surface a mart model for every grain that will likely need analysis (user, order, session, ...).**
- **Finally, I pay attention to incoming requests to iterate on models. For example, an ops stakeholder may soon need a mart model with a shipments grain. I'll also find opportunities to create int models as I start reusing business logic.** 

### Lineage Graph

<img width="1281" alt="Screen Shot 2022-10-16 at 10 54 11 AM" src="https://user-images.githubusercontent.com/109819898/196050565-e925cf82-e7f2-410b-97ab-4b70fc22741f.png">


### PART 2

What assumptions are you making about each model?
- **Primary keys are not null and unique**
- **Item quantities are positive**
- **Order statuses and event types are consistent with a set of expected values**

I focused on modeling this week rather than digging more deeply into tests.

 ### PART 3

 Which orders changed from week 1 to 2?
- **The following order IDs changed:**
    - **914b8929-e04a-40f8-86ee-357f2be3a2a2**
    - **939767ac-357a-4bec-91f8-a7b25edd46c9**
    - **05202733-0e17-4726-97c2-0520c024ab85**
