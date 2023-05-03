{{ config(materialized="ephemeral") }} 

{{ get_hierarchy("dmi") }}