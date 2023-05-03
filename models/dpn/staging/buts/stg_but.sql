{{ config(materialized='ephemeral') }}

select
    but_idr_business_unit,
    but_num_business_unit,
    but_num_typ_but
from {{source ('cds','d_business_unit')}}
