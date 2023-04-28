{{ config(materialized='ephemeral') }}

select
    id as pnt_num_product_nature,
    coalesce(id || ' ' || name, id::varchar(10), 'Unassigned') as product_nature_label
from {{source ('silver','product_nature')}}