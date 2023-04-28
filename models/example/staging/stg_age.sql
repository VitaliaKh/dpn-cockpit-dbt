

{{ config(materialized='ephemeral') }}

select id, Age as age
from {{source('schema_example', 'seed_age')}}

