{{ config(materialized='ephemeral') }}

select
    sku_idr_sku,
    case
       when brd_type_brand_libelle in ('AMI','MP') then brd_type_brand_libelle
    end as brd_type_brand_libelle,
    mdl_num_model_r3,
    sku_num_sku_r3 as item_code_r3,
    mdl_label,
    pnt_num_product_nature::bigint as pnt_num_product_nature,
    case when brd_type_brand_libelle = 'AMI' then null
         when ( mdl_label like '%1_0 %' or mdl_label like '%1_0' ) and brd_type_brand_libelle = 'MP' then 100
         when ( mdl_label like '%3_0 %' or mdl_label like '%3_0' ) and brd_type_brand_libelle = 'MP'then 500
         when ( mdl_label like '%5_0 %' or mdl_label like '%5_0' ) and brd_type_brand_libelle = 'MP' then 500
         when ( mdl_label like '%7_0 %' or mdl_label like '%7_0' ) and brd_type_brand_libelle = 'MP' then 900
         when ( mdl_label like '%9_0 %' or mdl_label like '%9_0' ) and brd_type_brand_libelle = 'MP' then 900
         else null
    end as segmentation_from_label
from {{source ('cds','d_sku_h')}}
where sku_date_end = '2999-12-31 23:59:59'