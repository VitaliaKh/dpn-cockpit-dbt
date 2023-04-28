{%- macro treate_date(date_field) -%}
    trunc({{date_field}},'MM') as yearmonth,
    weekofyear(date_add({{date_field}},1)) as week,
    date_add(trunc(date_add({{date_field}},1),'week'),5) as saturday
{%- endmacro -%}


