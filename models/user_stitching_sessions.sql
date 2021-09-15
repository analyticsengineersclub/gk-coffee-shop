{{ config(
    materialized='table'
) }}


with non_customers as (
select * 
from `analytics-engineers-club.web_tracking.pageviews`
where customer_id is NULL ),

customers as (
select * 
from `analytics-engineers-club.web_tracking.pageviews`
where customer_id is not NULL 
),

get_min_timestamp as (
select
customer_id, 
min(timestamp) as first_timestamp
from customers 
group by 1
),


get_unique_visitor_id as (
select 
get_min_timestamp.customer_id,
get_min_timestamp.first_timestamp,
customers.visitor_id as unique_visitor_id
from get_min_timestamp 
left join customers on get_min_timestamp.first_timestamp = customers.timestamp and 
    get_min_timestamp.customer_id = customers.customer_id
),



customers_and_unique_visitors as (
    select 
    customers.*,
    get_unique_visitor_id.unique_visitor_id  as the_unique_vistor_id
    from customers 
    left join get_unique_visitor_id
    on customers.customer_id = get_unique_visitor_id.customer_id 
),


clean_customers as (
select 
id, 
the_unique_vistor_id as visitor_id,
device_type,
timestamp,
page,
customer_id 
from customers_and_unique_visitors)

select * from clean_customers 
union all 
select * from non_customers  


