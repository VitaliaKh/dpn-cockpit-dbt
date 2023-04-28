

select id, Name as name
from {{source('schema_example', 'seed_name')}}

