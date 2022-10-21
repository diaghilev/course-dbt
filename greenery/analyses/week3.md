## Stakeholder Questions + Answers

### Conversion Rates

What is our overall conversion rate? **62.45**

**Conversion rate definition: sessions with a checkout / all sessions.**

```
SELECT 
    SUM(has_converted)/COUNT(has_converted)*100 AS overall_conversation_rate
FROM DEV_DB.DBT_HI.FACT_SESSIONS
```
What is our conversion rate by product? 

**Conversion rate is in the dim_product table.**

Theoretically, Why might certain products be converting at higher/lower rates than others?
- **Strength of product's value prop as expressed on the page.** (such as "product requires minimal upkeep")
- **Presence of social proof via reviews or photos featuring product in a customer's home.**
- **Alignment between the type of user brought to the page and the product's relevance to that user** (such as a city dweller directed to products that require a large plot of land)

### Macros

**Auto generated columns for event types rather than hard coding them.** 

```
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
```

### Permissions

**Added reporting role permissions into dbt_project.yml.**
```
models:
  greenery:
    marts: 
      +post-hook: 
        - "grant select on {{ this }} to role reporting"
```

### Packages

**Added a surrogate key to stg_order_items using the dbt_utils.surrogate_key macro. I then added a uniqueness test to that field.**

```
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
```

### Snapshots

The following orders have been updated since week 3:
- **8385cfcd-2b3f-443a-a676-9756f7eb5404**
- **e24985f3-2fb3-456e-a1aa-aaf88f490d70**
- **5741e351-3124-4de7-9dff-01a448e7dfd4**