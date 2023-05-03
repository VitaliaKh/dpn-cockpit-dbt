{{ config(materialized='ephemeral') }}

select
    ltrim('W',plant_id)::bigint as but_num_business_unit,
    case
      when plant_id::int is not null then 7
      when plant_id like 'W%'  then 9
    end as but_num_typ_but,
    distrib_channel,
    sales_org,
    purch_org
from {{source ('cds','sites_attribut_0plant_branches')}}
where sapsrc='PRT'