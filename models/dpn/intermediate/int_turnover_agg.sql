{{ config(materialized='view') }}

select
    yearmonth,
    week,
    saturday,
    mdl_num_model_r3,
    cnt_idr_country,
    cur_idr_currency,
    channel,
    the_to_type,
    CASE WHEN pl.purch_org ='Z001' and the_to_type='offline' THEN TRUE ELSE FALSE END as is_DPMI,
    sum(src.f_to_tax_in) AS turnover,
    sum(src.f_qty_item) AS qty,
    sum(margin) AS margin,
    sum(tds_top_eco_conception*f_to_tax_in) as to_eco_conception,
    sum((tds_top_buy_back+tds_top_trocathlon+tds_top_second_life)*f_to_tax_in) as to_second,
    sum(tds_top_workshop*f_to_tax_in) as to_workshop,
    sum(tds_top_location*f_to_tax_in) as to_rental
from {{ref ('stg_turnover')}} as src
left join {{ref('stg_sustainable')}} as sus using(the_transaction_id, tdt_num_line)
left join {{ref('stg_but')}} as but
    on but.but_idr_business_unit=src.but_idr_business_unit
    and but.but_num_typ_but =7
left join {{ref('int_plants')}} as pl
    on but.but_idr_business_unit=pl.but_idr_business_unit
    and pl.but_num_typ_but =7
    and pl.distrib_channel='02'
where 1=1
{{ dbt_utils.group_by(9) }}