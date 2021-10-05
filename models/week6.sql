

{{ config(
    materialized='table'
) }}

with first_table as (
    select
 *,
 case when category = 'coffee beans' THEN 'coffee_beans'
         when category = 'merch' THEN 'merch'
         when category = 'brewing supplies' THEN 'brewing_supplies'
         else category end as category_proper
from 
 {{ ref('products') }}
)


select
    date_trunc(product_created_at, month) as date_month,
    {% for coffee in ["coffee_beans", "merch", "brewing_supplies"] %}
    sum(case when category_proper = '{{coffee}}' then price end) as {{coffee}}_amount
    {% if not loop.last %},{% endif %}
    {% endfor %}
from
    first_table
group by 1







