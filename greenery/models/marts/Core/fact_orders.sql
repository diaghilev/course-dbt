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
)

SELECT 
    o.order_id,
    o.user_id,
    o.promo_id,
    p.promo_discount,
    o.address_id,
    o.created_at_utc,
    o.order_cost,
    o.shipping_cost,
    o.order_total,
    o.tracking_id,
    o.shipping_service,
    o.est_delivery_at_utc,
    o.delivered_at_utc,
    o.order_status,
    ic.item_count
FROM orders o
LEFT JOIN item_count ic
ON o.order_id = ic.order_id
LEFT JOIN promos p
ON o.promo_id = p.promo_id
ORDER BY 1