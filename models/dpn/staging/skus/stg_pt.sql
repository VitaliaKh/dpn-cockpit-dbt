{{ config(materialized='ephemeral') }}

select
    id as product_type_id
from {{source ('silver','product_type')}}
where codification = 'FP'