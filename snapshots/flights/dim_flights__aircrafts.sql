{% snapshot dim_flights__aircrafts %}

{{
   config(
       target_schema='snapshot',
       unique_key='aircraft_code',

       strategy='timestamp',
       updated_at='updated_at',
       dbt_valid_to_current="'2033-01-01'::date"
   )
}}

select
    "aircraft_code", 
    "model", 
    "range"
from
    {{ ref('stg_flights__aircrafts') }}


{% endsnapshot %}