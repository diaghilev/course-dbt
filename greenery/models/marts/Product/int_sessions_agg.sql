
{{
  config(
    materialized='view'
  )
}}

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
)

{%-
  set event_types = dbt_utils.get_column_values(
    table = ref('stg_events'),
        column = 'event_type',
            order_by = 'event_type asc'
  )
-%}

SELECT
    session_id
    , user_id
    {%- for event_type in event_types %}
    , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{event_type}}s
    {%- endfor %}
    , CASE WHEN checkouts = 0 THEN 0 ELSE 1 END AS has_converted
FROM events
GROUP BY 1,2