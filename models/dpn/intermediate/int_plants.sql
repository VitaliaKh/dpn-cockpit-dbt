{{ config(materialized='view') }}

select
    but_num_business_unit,
    but_num_typ_but,
    distrib_channel,
    sales_org,
    sales_org_text,
    purch_org,
    purch_org_text
from {{ref ('stg_plt_branches')}} as src
left join {{ref('stg_sales_org')}} as so using(sales_org)
left join {{ref('stg_purch_org')}} as po using(purch_org)