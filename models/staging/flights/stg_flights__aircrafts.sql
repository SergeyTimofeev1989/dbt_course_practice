{{
  config(
    materialized = 'table'
    )
}}
select
    "aircraft_code", 
    "model", 
    "range"
from
    {{ source('demo_src', 'aircrafts') }} -- demo_src указано в поле name в файле _flights_sources.yml, aircrafts - название таблицы