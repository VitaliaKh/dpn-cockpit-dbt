{{ config(materialized='ephemeral') }}

{%- for the_to_type in ['online','offline'] -%}
    {%- set commun_columns=[
                            treate_date('tdt_date_to_ordered')|indent,
                            'sku_idr_sku',
                            'but_idr_business_unit',
                            'cur_idr_currency',
                            'cnt_idr_country',
                            'the_to_type',
                            get_channel(the_to_type),
                            'f_to_tax_in',
                            'f_qty_item',
                            get_margin(the_to_type),
                            'the_transaction_id',
                            'tdt_num_line'
        ]
    -%}
    select
    {%- for column in commun_columns %}
        {{column}}{%- if not loop.last -%},{%- endif -%}
    {% endfor %}
    from {{source ('cds','turnover_'+the_to_type)}}
    where the_to_type='{{the_to_type}}'
{% if not loop.last -%} union all {%- endif %}
{% endfor -%}