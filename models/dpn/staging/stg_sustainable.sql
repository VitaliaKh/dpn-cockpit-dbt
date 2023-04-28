{{ config(materialized='ephemeral') }}

select
    the_transaction_id,
    tdt_num_line,
    tds_top_eco_conception,
    tds_top_buy_back,
    tds_top_trocathlon,
    tds_top_second_life,
    tds_top_workshop,
    tds_top_location,
    the_to_type
from {{source ('cds','f_transaction_sustainable')}}
