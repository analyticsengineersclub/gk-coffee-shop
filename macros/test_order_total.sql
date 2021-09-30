{% test order_total(model, column_name) %}
    select *
    from {{ model }}
    where {{ column_name }} <= 0 
{% endtest %}