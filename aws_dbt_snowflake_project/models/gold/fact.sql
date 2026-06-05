{% set configs = [
    {
        "table" : "silver_booking",
        "columns" : "sb.*",
        "alias" : "sb"
    },
    {
        "table" : "silver_listings",
        "columns" : "",
        "alias" : "sl",
        "join_condition" : "sb.listing_id = sl.listing_id"
    },
    {
        "table" : "silver_host",
        "columns" : "",
        "alias" : "sh",
        "join_condition" : "sl.host_id = sh.host_id"
    }
] %}

SELECT
{% for config in configs %}
    {% if config.columns != "" %}
        {{ config.columns }}
        {% if not loop.last %},{% endif %}
    {% endif %}
{% endfor %}
FROM {{ ref(configs[0].table) }} AS {{ configs[0].alias }}
{% for config in configs[1:] %}
LEFT JOIN {{ ref(config.table) }} AS {{ config.alias }}
    ON {{ config.join_condition }}
{% endfor %}
