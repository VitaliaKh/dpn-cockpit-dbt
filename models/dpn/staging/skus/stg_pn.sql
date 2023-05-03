{{ config(materialized='ephemeral') }}

select
    id as product_nature_id,
    coalesce(id || ' ' || name, id::varchar(10), 'Unassigned') as product_nature_label
from {{source ('silver','product_nature')}}