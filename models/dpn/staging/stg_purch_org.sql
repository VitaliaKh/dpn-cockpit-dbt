{{ config(materialized='ephemeral') }}

select
     purch_org,
     purch_org_text
from {{source ('cds','supply_plant')}}
group by 1,2