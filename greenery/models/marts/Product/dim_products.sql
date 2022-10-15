{{
  config(
    materialized='table'
  )
}}

WITH product AS (
    SELECT * FROM {{ ref('stg_products') }}
), 

product_events AS (
    SELECT * FROM {{ ref('int_product_events') }}
),

product_orders AS (
    SELECT * FROM {{ ref('int_product_orders') }}
)

SELECT
    p.product_id,
    p.product_name,
    p.product_price,
    p.product_quantity,
    pe.daily_page_views,
    pe.daily_add_to_carts,
    po.daily_orders,
    po.daily_revenue
FROM product p
LEFT JOIN product_events pe
ON p.product_id = pe.product_id
LEFT JOIN product_orders po
ON p.product_id = po.product_id