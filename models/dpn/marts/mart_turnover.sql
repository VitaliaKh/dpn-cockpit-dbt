{{ config(materialized='table')}}

select
    src.*,
    hrc.*,
    exc.*,
    cnt.*
from {{ref('int_turnover_agg')}} src
left join {{ref('int_hierarchy')}} hrc using(mdl_num_model_r3)
left join {{ref('int_exc_rates')}} exc using (cur_idr_currency, yearmonth)
left join {{ref("int_countries")}} cnt using(cnt_idr_country)