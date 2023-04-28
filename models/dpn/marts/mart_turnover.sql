{{ config(materialized='table')}}

select
    src.*
from {{ref('int_turnover_agg')}} src
