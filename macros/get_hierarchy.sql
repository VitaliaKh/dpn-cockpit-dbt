{% macro get_hierarchy(type) -%}
    {%- set hierarchies={"dmi":"org_fa=1", "dri": "org_fa=2", "dii":"org_fa=3"}
    -%}
    {%- set levels =  ["fa", "sr", "ray", "unv"]-%}
    select
        mdl_num_model_r3,
        {%- for level in levels %}
            coalesce(niv_{{level}} || ' ' || {{level}}_label, niv_{{level}}::varchar(10), 'Unassigned') AS {{type}}_{{level}} 
            {%- if not loop.last -%},{%- endif -%}
        {%- endfor %}
    from {{source ('cds','d_hierarchy_supply')}}
    where {{hierarchies[type]}}
{%- endmacro %}