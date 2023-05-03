{% macro date_condition(date_field) -%}
{{date_field}}>=dateadd(YEAR, -2, trunc(getdate(),'YEAR'))
{%- endmacro %}