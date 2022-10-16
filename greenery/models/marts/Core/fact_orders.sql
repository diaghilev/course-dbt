{{
  config(
    materialized='table'
  )
}}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),

promos AS (
    SELECT * FROM {{ ref('stg_promos') }}
),

item_count AS (
    SELECT
        order_id,
        SUM(quantity) AS item_count
    FROM order_items
    GROUP BY 1
),

promo_discount AS (
    SELECT
        promo_id,
        promo_discount
    FROM promos
)

SELECT 
    o.order_id,
    user_id,
    o.promo_id,
    promo_discount,
    address_id,
    created_at_utc,
    order_cost,
    shipping_cost,
    order_total,
    tracking_id,
    shipping_service,
    est_delivery_at_utc,
    delivered_at_utc,
    order_status,
    item_count
FROM orders o
LEFT JOIN item_count ic
ON o.order_id = ic.order_id
LEFT JOIN promo_discount pd
ON o.promo_id = pd.promo_id
ORDER BY 1