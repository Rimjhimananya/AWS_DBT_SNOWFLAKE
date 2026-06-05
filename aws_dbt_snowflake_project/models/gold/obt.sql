{% set configs = [
    {
        "table" : "silver_booking",
        "columns" : "*",
        "alias" : "silver_booking"
    },
    {
        "table" : "silver_listings",
        "columns" : "silver_listings.host_id, silver_listings.property_type, silver_listings.room_type, silver_listings.city, silver_listings.country, silver_listings.accommodates, silver_listings.bedrooms, silver_listings.bathrooms, silver_listings.price_per_night, silver_listings.price_per_night_tag, silver_listings.created_at as listing_created_at",
        "alias" : "silver_listings",
        "join_condition" : "silver_booking.listing_id = silver_listings.listing_id"
    },
    {
        "table" : "silver_host",
        "columns" : "silver_host.host_name, silver_host.host_since, silver_host.is_superhost, silver_host.response_rate, silver_host.response_rate_quality, silver_host.created_at as host_created_at",
        "alias" : "silver_host",
        "join_condition" : "silver_listings.host_id = silver_host.host_id"
    }
] %}

SELECT
{% for config in configs %}
    {% if config.columns == "*" %}
        {{ config.alias }}.*
    {% else %}
        {{ config.columns }}
    {% endif %}
    {% if not loop.last %},{% endif %}
{% endfor %}
FROM {{ ref(configs[0].table) }} AS {{ configs[0].alias }}
{% for config in configs[1:] %}
LEFT JOIN {{ ref(config.table) }} AS {{ config.alias }}
    ON {{ config.join_condition }}
{% endfor %}
