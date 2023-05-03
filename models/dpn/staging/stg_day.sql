{{ config(materialized="ephemeral") }}

select 
    trunc(day_id_day,'MM') as yearmonth
from {{source('cds','d_day')}}
where {{date_condition('day_id_day')}}
    and day_id_day<=trunc(getdate(),'MM') 
group by 1
order by 1 desc