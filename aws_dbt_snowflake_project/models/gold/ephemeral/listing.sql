{{
  config(
    materialized = 'ephemeral'
  )
}}

select
    listing_id,
    property_type,
    room_type,
    city,
    country,
    accommodates,
    bedrooms,
    bathrooms,
    price_per_night_tag,
    CREATED_AT
from {{ ref('silver_listings') }}
