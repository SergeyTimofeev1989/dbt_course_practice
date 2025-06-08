{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'append'
    )
}}
select
    "book_ref",
    "book_date",
    "total_amount"
from
    {{ source('demo_src', 'bookings') }}

{% if is_incremental() %}
where
    book_ref > (select MAX(book_ref) from  {{ this }}) -- Когда используем this то ссылаемся на такую же таблицу(как и имя модели) в БД
{% endif %}

-- Модель должна существовать в БД
-- В БД должна существовать таблица соответствующей данной модели
-- При запуске обновления моделей не передан флаг full-refresh
-- is_incremental 