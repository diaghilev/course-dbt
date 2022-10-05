{{
  config(
    materialized='view'
  )
}}

WITH products_source AS (
  SELECT * FROM {{ source('postgres', 'products') }}
)

SELECT 
    product_id,
    name,
    price,
    inventory 
FROM products_source