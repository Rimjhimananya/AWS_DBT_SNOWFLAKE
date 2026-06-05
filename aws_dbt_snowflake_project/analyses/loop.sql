{% set cols = ['NIGHTS_BOOKED', 'BOOKING_ID', 'BOOKING_AMOUNT'] %}

Select
{% for col in cols %}
  {{ col }}{% if not loop.last %},{% endif %}
{% endfor %}
from {{ ref('bronze_bookings') }}
