{% snapshot snapshot_orders %}

{{
  config(
    target_database = 'DEV_DB', 
    target_schema = 'DBT_HI', 
    strategy='check',
    unique_key='order_id',
    check_cols=['status']
   )
}}

SELECT * FROM {{ source('postgres', 'orders')}}

{% endsnapshot %}