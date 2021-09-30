-- select
--   date_trunc(product_created_at, month) as date_month,
--   sum(case when category = 'coffee beans' then price end) as coffee_beans_amount,
--   sum(case when category = 'merch' then price end) as merch_amount,
--   sum(case when category = 'brewing supplies' then price end) as brewing_supplies_amount
-- -- you may have to `ref` a different model here, depending on what you've built previously
-- from {{ ref('products') }}
-- group by 1




{% set coffee_types = ["coffee_beans", "merch", "brewing_supplies"] %}


select
    date_trunc(product_created_at, month) as date_month,
    {% for coffee in coffee_types %}
    sum(case when category = '{{coffee}}' then price end) as '{{coffee}}'_amount
    {% endfor %}
from
    {{ ref('products') }}
group by 1
