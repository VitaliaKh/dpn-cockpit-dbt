{{ config(materialized="view") }}

select
    sku.mdl_num_model_r3,
    sku.mdl_label,
    sku.product_nature_id,
    min(sku.brd_type_brand_libelle) as brd_type_brand_libelle,
    min(sku.segmentation_from_label) as segmentation_from_label
from {{ ref("stg_sku") }} sku {{ dbt_utils.group_by(3) }}