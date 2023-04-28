
{{ config(materialized='view') }}

select id, initcap(name) as name
from {{ref('stg_name')}}



