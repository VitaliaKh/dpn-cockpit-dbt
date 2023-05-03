{{ config(materialized="view") }}

select
    src.yearmonth,
    src.week,
    src.saturday,
    sku.mdl_num_model_r3,
    src.cnt_idr_country,
    src.cur_idr_currency,
    src.channel,
    src.the_to_type,
    case
        when pl.purch_org = 'Z001' and src.the_to_type = 'offline' then true else false
    end as is_dpmi,
    sum(src.f_to_tax_in) as turnover,
    sum(src.f_qty_item) as qty,
    sum(src.margin) as margin,
    sum(src.f_to_tax_in * sus.tds_top_eco_conception) as to_eco_conception,
    sum(
        src.f_to_tax_in
        * (sus.tds_top_buy_back + sus.tds_top_trocathlon + sus.tds_top_second_life)
    ) as to_second,
    sum(src.f_to_tax_in * sus.tds_top_workshop) as to_workshop,
    sum(src.f_to_tax_in * sus.tds_top_location) as to_rental
from {{ ref("stg_turnover") }} as src
inner join {{ref('stg_sku')}} as sku using(sku_idr_sku)
left join {{ ref("stg_sustainable") }} as sus using (the_transaction_id, tdt_num_line)
left join
    {{ ref("stg_but") }} as but
    on src.the_to_type='offline'
    and but.but_idr_business_unit = src.but_idr_business_unit
    and but.but_num_typ_but = 7
left join
    {{ ref("int_plants") }} as pl
    on but.but_num_business_unit = pl.but_num_business_unit
    and pl.but_num_typ_but = 7
    and pl.distrib_channel = '02'
where 1 = 1 
{{ dbt_utils.group_by(9) }}
order by yearmonth desc, cur_idr_currency, cnt_idr_country, mdl_num_model_r3