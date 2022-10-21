{{
  config(
    materialized='table'
  )
}}

WITH product_events AS (
    SELECT * FROM {{ ref('int_product_events') }}
),

product_orders AS (
    SELECT * FROM {{ ref('int_product_orders') }}
),

product_conversions AS (
    SELECT * FROM {{ ref('int_product_conversions')}}
)

SELECT
    po.product_id,
    po.product_name,
    po.current_price,
    po.current_inventory,
    po.daily_orders,
    po.daily_revenue,
    pe.daily_page_views,
    pe.daily_add_to_carts,
    pc.conversion_rate
FROM product_orders po
LEFT JOIN product_events pe
ON po.product_id = pe.product_id
LEFT JOIN product_conversions pc
ON po.product_id = pc.product_id