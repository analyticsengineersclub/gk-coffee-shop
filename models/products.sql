{{ config(
    materialized='table'
) }}

select 
product_prices.id,
product_prices.product_id,
product_prices.price,
product_prices.created_at as price_created_at,
product_prices.ended_at as price_ended_at,
products.name,
products.category,
products.created_at as product_created_at
from analytics-engineers-club.coffee_shop.product_prices product_prices
left join analytics-engineers-club.coffee_shop.products products
on product_prices.product_id = products.id