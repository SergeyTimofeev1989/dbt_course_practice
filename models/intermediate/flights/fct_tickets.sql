{{
  config(
    materialized = 'table',
    )
}}
select
  "ticket_no",
  "book_ref",
  "passenger_id",
  "passenger_name",
  "contact_data"
from 
  {{ ref('stg_flights__tickets') }}
where
  passenger_id not in (select * from {{ ref('id_passengers') }})