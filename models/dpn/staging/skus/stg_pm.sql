{{ config(materialized='ephemeral') }}

select
    sap as mdl_num_model_r3,
    parent_product_conception_id as product_conception_id
from {{source ('silver','product_model')}}