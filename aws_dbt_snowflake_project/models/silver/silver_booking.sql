{{
  config(
    materialized = 'incremental',
    unique_key = 'booking_id'
  )
}}

select
    booking_id,
    listing_id,
    booking_date,
    {{ multiply('NIGHTS_BOOKED', 'BOOKING_AMOUNT', 2) }} + CLEANING_FEE + SERVICE_FEE as TOTAL_AMOUNT,
    booking_status,
    created_at
from {{ ref('bronze_bookings') }}
