{{
  config(
    materialized='view'
  )
}}

WITH product AS (
    SELECT * FROM {{ ref('stg_products') }}
), 

order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),

orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

product_order_items AS (
    SELECT
        p.product_id,
        p.product_name,
        p.product_price AS current_price,
        p.product_quantity AS current_inventory,
        DATE_TRUNC(day, o.created_at_utc) as date,
        SUM(oi.quantity) AS orders,
        SUM(oi.quantity*p.product_price) AS revenue
    FROM product p
    LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
    LEFT JOIN orders o
    ON o.order_id = oi.order_id
    GROUP BY 1,2,3,4,5
)
SELECT 
    product_id,
    product_name,
    current_price,
    current_inventory,
    AVG(orders) AS daily_orders,
    AVG(revenue) AS daily_revenue 
FROM product_order_items
GROUP BY 1,2,3,4
ORDER BY 6 DESC
