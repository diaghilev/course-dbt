{{
  config(
    materialized='table'
  )
}} 

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
),

sessions_agg AS (
    SELECT * FROM {{ ref('int_sessions_agg') }}
)

--I exclude package_shipped info from this model because shipment info could (theoretically) fit best in another model with detailed metrics for an operations team.
SELECT 
    e.session_id,
    e.user_id,
    MIN(e.created_at_utc) as session_start,
    MAX(e.created_at_utc) as session_end,
    DATEDIFF(m, session_start, session_end) as session_length_mins,
    sa.session_page_views,
    sa.session_add_to_carts,
    sa.session_checkouts,
    sa.has_converted
FROM events e
LEFT JOIN sessions_agg sa
ON e.session_id = sa.session_id
WHERE event_type <> 'package_shipped'
GROUP BY 1,2,6,7,8,9