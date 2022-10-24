
{{
  config(
    materialized='view'
  )
}}

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
)

-- Hard coding event types has downsides, but this way I could rename and order the resulting columns. While a macro wasn't necessary here, it was good practice!
SELECT
    session_id,
    user_id,
    {{ agg_event_type('page_view') }} AS session_page_views,
    {{ agg_event_type('add_to_cart') }} AS session_add_to_carts,
    {{ agg_event_type('checkout') }} AS session_checkouts,
    {{ agg_event_type('package_shipped') }} AS session_package_shippeds,
    CASE WHEN session_checkouts = 0 THEN 0 ELSE 1 END AS has_converted
FROM events
GROUP BY 1,2
