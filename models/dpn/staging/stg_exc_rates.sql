{{ config(materialized="ephemeral") }}

SELECT
    ROW_NUMBER ( )  OVER (partition by from_currency order by start_date desc) as id,
    trunc(start_date,'MM') as yearmonth,
    from_currency as cur_code_currency,
    rate,
    base, 
    real_rate
FROM {{source('cds','mtf_exchange_rate')}} exc
WHERE 1 = 1
    AND rate_type = "CRE"
    AND to_currency = 'EUR'
    AND {{date_condition('start_date')}}
order by yearmonth desc, cur_code_currency 
