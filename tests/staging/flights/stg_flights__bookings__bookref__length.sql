{{
  config(
    severity = 'warn',
    warn_if = '>1500000'
    )
}}

-- severity = 'warn' Если тест упадет, то будет предупреждение, а не ошибка.
-- Если записей было меньше чем 1500000(допустимое значение), то предпреждение не выводить. 

-- severity = 'error' Если тест упадет, и будет error_if = '>1400000', то и ошибки не будет
SELECT
    b.book_ref
FROM
    {{ ref('stg_flights__bookings') }} b
    JOIN {{ ref('stg_flights__tickets') }} t
    ON b.book_ref = t.book_ref
WHERE
    length(b.book_ref) > 5 -- Ищем только те строчки, которые больше 6, если их нет, то тест успешно пройден

-- При выполнении dbt build, так же запускаются тесты