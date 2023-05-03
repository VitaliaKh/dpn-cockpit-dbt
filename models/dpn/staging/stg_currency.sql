{{ config(materialized="ephemeral") }}

select
    cur_idr_currency,
    cur_code_currency
from {{source('cds','d_currency')}}