SELECT
    DISTINCT fare_conditions
FROM
    {{ ref('stg_flights__seats') }}