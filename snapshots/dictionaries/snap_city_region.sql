{% snapshot snap_city_region %}

{{
   config(
       target_schema='snapshot',
       unique_key='city',

       strategy='timestamp',
       updated_at='updated_at',
       dbt_valid_to_current="'2033-01-01'::date"
   )
}}

SELECT
    city,
    region,
    updated_at
FROM
    {{ ref('city_region') }}

{% endsnapshot %}