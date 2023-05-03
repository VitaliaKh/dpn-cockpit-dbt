{{ config(materialized="view") }}

with rates as (
    SELECT 
    * 
    FROM {{ref('stg_exc_rates')}} exc
    UNION ALL
    select
        0 as id,
        dates.yearmonth,
        cur_code_currency,
        rate,
        base, 
        real_rate
    from {{ref('stg_exc_rates')}} exc
    full join (
        select 
            d.yearmonth
            from {{ref('stg_day')}} d, {{ref('stg_exc_rates')}} r
            group by 1
            having d.yearmonth>max(r.yearmonth) 
            order by 1 desc
            
    ) dates
    where id = 1
    order by yearmonth desc, cur_code_currency)

select
*
from rates
inner join {{ref('stg_currency')}} cur using(cur_code_currency)
order by yearmonth desc, cur_idr_currency