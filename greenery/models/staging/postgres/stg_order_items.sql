{{
  config(
    materialized='view'
  )
}}

WITH order_items_source AS (
  SELECT * FROM {{ source('postgres', 'order_items') }}
)

SELECT 
    {{ dbt_utils.surrogate_key(['order_id','product_id']) }} AS order_product_id,
    order_id,
    product_id,
    quantity   
FROM order_items_source