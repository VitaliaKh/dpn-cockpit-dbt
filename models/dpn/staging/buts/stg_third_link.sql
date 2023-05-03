{{ config(materialized="ephemeral") }}

select 
    tir_son_third_num as country_num,
    tir_father_third_num as zone_num   
from {{source('cds','d_third_link')}}
where tyl_third_link_type_tyl=401
order by 1