{{
  config(
    materialized='table'
  )
}}

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
), 

users AS (
    SELECT * FROM {{ ref('stg_users') }}
)

SELECT 
    e.session_id,
    e.user_id,
    u.first_name,
    u.last_name,
    MIN(e.created_at_utc) as session_start,
    MAX(e.created_at_utc) as session_end,
    DATEDIFF(m,session_start, session_end) as session_length_mins,
    SUM(CASE WHEN e.event_type = 'page_view' THEN 1 ELSE 0 END) AS session_page_views,
    SUM(CASE WHEN e.event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS session_add_to_carts,
    SUM(CASE WHEN e.event_type = 'checkout' THEN 1 ELSE 0 END) AS session_checkouts,
    CASE WHEN session_checkouts = 0 THEN 0 ELSE 1 END AS has_converted
FROM events e
LEFT JOIN users u
ON e.user_id = u.user_id
WHERE event_type <> 'package_shipped'
GROUP BY 1,2,3,4