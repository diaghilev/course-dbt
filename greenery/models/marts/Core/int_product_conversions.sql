{{
  config(
    materialized='view'
  )
}}

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
),

sessions_agg AS (
    SELECT * FROM {{ ref('int_sessions_agg') }}
),

session_product AS (
  SELECT
    e.session_id,
    e.product_id,
    sa.has_converted
  FROM events e
  LEFT JOIN sessions_agg sa
  ON e.session_id = sa.session_id 
  WHERE e.event_type = 'add_to_cart'
)

SELECT
    product_id,
    SUM(has_converted) AS converted_sessions,
    COUNT(has_converted) AS total_sessions,
    SUM(has_converted)/COUNT(has_converted)*100 AS conversion_rate
FROM session_product
GROUP BY 1