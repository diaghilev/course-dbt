{{
  config(
    materialized='view'
  )
}}

WITH users_source AS (
  SELECT * FROM {{ source('postgres', 'users') }}
)

SELECT 
    user_id,
    first_name, 
    last_name, 
    email, 
    phone_number, 
    created_at AS created_at_utc, 
    updated_at AS updated_at_utc, 
    address_id
FROM users_source