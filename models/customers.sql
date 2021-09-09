with main as(select *, 
COUNT(customer_id) OVER
(PARTITION BY created_at) AS purchase_number
from `analytics-engineers-club.coffee_shop.orders`orders
left join `analytics-engineers-club.coffee_shop.customers` customers on orders.customer_id = customers.id),

total_orders as (
select customer_id, count(distinct id) as number_of_orders
from  `analytics-engineers-club.coffee_shop.orders`
group by customer_id
)

select main.customer_id, name, email, created_at as first_order_date, number_of_orders  from main
left join total_orders on main.customer_id = total_orders.customer_id
where purchase_number = 1
order by first_order_date