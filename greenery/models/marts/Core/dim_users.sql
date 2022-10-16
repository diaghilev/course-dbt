{{
  config(
    materialized='table'
  )
}}

-- I will likely create 1 or more int tables from the following CTEs

WITH users AS (
    SELECT * FROM {{ ref('stg_users') }}
),

events AS (
    SELECT * FROM {{ ref('stg_events') }}
), 

orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
), 

order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
), 

user_events AS (
    SELECT
        user_id,
        COUNT(distinct session_id) AS total_sessions
    FROM events
    GROUP BY 1 
),

user_orders AS (
    SELECT
        user_id,
        COUNT(distinct order_id) AS total_orders,
        SUM(order_total) AS total_spend
    FROM orders
    GROUP BY 1 
),

user_order_items AS(
    SELECT
        u.user_id,
        COUNT(oi.quantity) AS items_ordered
    FROM users u
    LEFT JOIN orders o
    ON u.user_id = o.user_id
    LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
    GROUP BY 1
)
SELECT 
    u.user_id, 
    u.first_name, 
    u.last_name,
    u.created_at_utc,
    u.updated_at_utc,
    u.email,
    u.phone_number,
    u.address_id,
    -- add mins active,
    -- add promo usage,
    COALESCE(ue.total_sessions,0) AS total_sessions,
    COALESCE(uo.total_orders,0) AS total_orders,
    COALESCE(uoi.items_ordered,0) AS total_items_ordered,
    COALESCE(uo.total_spend,0) AS total_spend
FROM DEV_DB.DBT_HI.STG_USERS u
LEFT JOIN user_orders uo
ON u.user_id = uo.user_id
LEFT JOIN user_events ue
ON u.user_id = ue.user_id
LEFT JOIN user_order_items uoi
ON u.user_id = uoi.user_id
ORDER BY total_spend DESC