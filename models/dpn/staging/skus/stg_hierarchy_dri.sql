{{ config(materialized='ephemeral') }}

select
    mdl_num_model_r3,
    coalesce(niv_fa || ' ' || fa_label, niv_fa::varchar(10), 'Unassigned') AS dri_fa, --family
    coalesce(niv_sr || ' ' || sr_label, niv_sr::varchar(10), 'Unassigned') AS dri_sr, --subdepartment
    coalesce(niv_ray || ' ' || ray_label, niv_ray::varchar(10), 'Unassigned') AS dri_ray, --department
    coalesce(niv_unv || ' ' || unv_label, niv_unv::varchar(10), 'Unassigned') AS dri_unv --universe
from {{source ('cds','d_hierarchy_supply')}}
where org_fa=2