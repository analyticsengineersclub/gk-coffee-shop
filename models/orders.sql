{{ config(
    materialized='table'
) }}

with first_table as (
    select *,
	LAG(id ,1) OVER ( partition by customer_id
		ORDER BY created_at
	) prev_order_id
 from `analytics-engineers-club.coffee_shop.orders`)

 select
 id, 
 created_at,
 customer_id,
 total,
 address,
 state,
 zip,
 case when prev_order_id is null then 'New Customer Order' else 'Returning Customer Order' end new_customer_flag 
 from first_table