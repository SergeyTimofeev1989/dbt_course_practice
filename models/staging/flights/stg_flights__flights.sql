{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = ['flight_id'],
        tags = ['some_table'],
        merge_update_columns = ['scheduled_departure', 'scheduled_arrival'],
        on_shema_change = 'fail'
    ) 
}} -- С помощью команды dbt build --select 'tag:some_table' можно построить только те модели у которых стоит указанный тег
select
    "flight_id",
    "flight_no",
    "scheduled_departure",
    "scheduled_arrival",
    "departure_airport",
    "arrival_airport",
    "status",
    "aircraft_code",
    "actual_departure",
    "actual_arrival"
from
    {{ source('demo_src', 'flights') }}
{% if is_incremental() %} 
-- is_incremetal возвращает true, если: 
-- 1. Модель уже существует в БД 
-- 2. В БД должна существовать таблица соответствующая данной модели
-- 3. При запуске обновления модели не передан флаг full-refresh
-- 4. У модели тип материализации установлен incremental
where
    scheduled_departure < (SELECT MAX(scheduled_departure) FROM {{ this }}) - interval '100 day'
{% endif %}
