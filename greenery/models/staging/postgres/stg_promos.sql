{{
  config(
    materialized='view'
  )
}}

WITH promos_source AS (
  SELECT * FROM {{ source('postgres', 'promos') }}
)

SELECT 
    promo_id,
    discount*.01 AS promo_discount,
    status AS promo_status 
FROM promos_source