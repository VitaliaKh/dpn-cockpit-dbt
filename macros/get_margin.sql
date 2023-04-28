{% macro get_margin(the_to_type) -%}

    {%- if the_to_type=='online' -%}

        f_tdt_margin_estimate as margin

    {%- else -%}

        f_margin_estimate as margin

    {%- endif -%}

{%- endmacro %}


