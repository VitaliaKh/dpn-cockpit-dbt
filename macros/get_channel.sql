{% macro get_channel(the_to_type, digital_field='rdt_idr_reallocated_digital_type') -%}
{%
    set digital_types = {
        'INSTORE': (0, 2, 6, 7, 8, 9, 11),
        'OUTSTORE': (1, 3, 4, 5, 12, 13),
        'B2B': (10,'B2B')
        }
%}

    {%- if the_to_type=='online' -%}
        case
        {%- for digital_type, digital_array in digital_types.items() %}
             when {{digital_field}} in {{digital_array}} then "{{digital_type}}"
        {%- endfor %}
        end

    {%- else -%}

        'INSTORE'

    {%- endif %} as channel
{%- endmacro %}


