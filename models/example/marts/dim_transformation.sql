
{{ config(materialized='table') }}

select id, name, age
from {{ref('stg_age')}}
inner join {{ref('int_transformation')}} using (id)



