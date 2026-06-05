{{
  config(
    materialized = 'ephemeral'
  )
}}

select
    host_id,
    host_name,
    host_since,
    is_superhost,
    RESPONSE_RATE_QUALITY,
    CREATED_AT
from {{ ref('silver_host') }}
