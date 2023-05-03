{{ config(materialized='ephemeral') }}

select
    sales_org,
    sales_org_text
from {{source ('cds','sales_organizations_texts')}}
where language_id='EN'