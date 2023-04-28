{{ config(materialized='ephemeral') }}

select
    id as product_conception_id,
    product_type_id,
    coalesce(product_code::bigint,0) as conception_code,
    coalesce(display_name,'Unassigned') as conception_code_label
from {{source ('silver','product_conception')}}