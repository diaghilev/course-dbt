## Stakeholder Questions + Answers

1. How many users do we have? **130 users**
```
SELECT COUNT(DISTINCT user_id) 
FROM DEV_DB.DBT_HI.STG_USERS;
```

2. On average, how many orders do we receive per hour? **7.52 orders**
```
WITH orders as (
    SELECT
        DATE_TRUNC('hour', created_at_utc) AS hour,
        COUNT(DISTINCT order_id) AS order_count
    FROM DEV_DB.DBT_HI.STG_ORDERS 
    GROUP BY 1
)
SELECT avg(order_count) FROM orders;
```

3. On average, how long does an order take from being placed to being delivered? **3.89 days**
```
WITH delivery_duration AS (
    SELECT
        order_id,
        DATEDIFF(day,created_at_utc,delivered_at_utc) AS delivery_duration
    FROM DEV_DB.DBT_HI.STG_ORDERS
    WHERE order_status = 'delivered'
)
SELECT AVG(delivery_duration) FROM delivery_duration;
```

4. How many users have only made one purchase? Two? Three+? **25, 28, 71 users, respectively**
```
WITH order_count AS (
    SELECT 
        user_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM DEV_DB.DBT_HI.STG_ORDERS
    GROUP BY user_id
    ORDER BY order_count DESC
)
SELECT
    SUM(CASE WHEN order_count = 1 THEN 1 ELSE 0 END) AS purchase_1,
    SUM(CASE WHEN order_count = 2 THEN 1 ELSE 0 END) AS purchase_2,
    SUM(CASE WHEN order_count > 2 THEN 1 ELSE 0 END) AS purchase_more
FROM order_count;
```

5. On average, how many unique sessions do we have per hour? **16.32 sessions**
```
WITH sessions AS (
    SELECT
        DATE_TRUNC('hour', created_at_utc) AS hour,
        COUNT(DISTINCT session_id) AS session_count
    FROM DEV_DB.DBT_HI.STG_EVENTS
    GROUP BY hour
)
SELECT AVG(session_count) AS avg_sessions FROM sessions;
```

