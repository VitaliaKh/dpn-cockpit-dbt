{{ config(materialized="ephemeral") }} 

{{ get_hierarchy("dri") }}