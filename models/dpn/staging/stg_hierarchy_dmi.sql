{{ config(materialized='ephemeral') }}

select
    mdl_num_model_r3,
    coalesce(niv_fa || ' ' || fa_label, niv_fa::varchar(10), 'Unassigned') AS dmi_fa, --family DMI
    coalesce(niv_sr || ' ' || sr_label, niv_sr::varchar(10), 'Unassigned') AS dmi_sr, --subdepartment DMI
    coalesce(niv_ray || ' ' || ray_label, niv_ray::varchar(10), 'Unassigned') AS dmi_ray, --department DMI
    coalesce(niv_unv || ' ' || unv_label, niv_unv::varchar(10), 'Unassigned') AS dmi_unv --universe DMI,
from {{source ('cds','d_hierarchy_supply')}}
where org_fa=1