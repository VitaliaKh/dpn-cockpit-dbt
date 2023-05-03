{{ config(materialized="view") }}

select *
from {{ ref("int_model") }} sku
left join {{ ref("stg_pn") }} pn using (product_nature_id)
left join {{ ref("stg_pm") }} pm using (mdl_num_model_r3)
left join {{ ref("stg_pc") }} pc using (product_conception_id)
left join {{ ref("stg_hierarchy_dmi") }} dmi using (mdl_num_model_r3)
left join {{ ref("stg_hierarchy_retail") }} dri using (mdl_num_model_r3)
left join {{ ref("stg_hierarchy_industrial_process") }} dii using (mdl_num_model_r3)