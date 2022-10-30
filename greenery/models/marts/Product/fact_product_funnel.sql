{{
  config(
    materialized='table'
  )
}} 

WITH sessions_agg AS (
    SELECT * FROM {{ ref('int_sessions_agg') }}
)

-- In a business setting, I might create a daily_funnel model so that the following rates could be monitored over time. 
SELECT
    SUM(CASE WHEN session_page_views > 0 THEN 1 ELSE 0 END)/COUNT(session_id)*100 AS view_conversion_rate,
    SUM(CASE WHEN session_add_to_carts > 0 THEN 1 ELSE 0 END)/COUNT(session_id)*100 AS add_conversion_rate,
    SUM(CASE WHEN session_checkouts > 0 THEN 1 ELSE 0 END)/COUNT(session_id)*100 AS checkout_conversion_rate
FROM sessions_agg