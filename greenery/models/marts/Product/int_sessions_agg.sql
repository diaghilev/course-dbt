
{{
  config(
    materialized='view'
  )
}}

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
)

SELECT
    session_id,
    user_id, 
    SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS session_page_views,
    SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS session_add_to_carts,
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS session_checkouts,
    SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS session_package_shippeds,
    CASE WHEN session_checkouts = 0 THEN 0 ELSE 1 END AS has_converted
FROM events
GROUP BY 1,2