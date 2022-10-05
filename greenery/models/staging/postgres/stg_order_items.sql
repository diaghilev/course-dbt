{{
  config(
    materialized='view'
  )
}}

WITH order_items_source AS (
  SELECT * FROM {{ source('postgres', 'order_items') }}
)

SELECT 
    order_id,
    product_id,
    quantity   
FROM order_items_source