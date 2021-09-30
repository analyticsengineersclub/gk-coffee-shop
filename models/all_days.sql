with all_days as ({{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2021-01-01' as date)",
    end_date="cast('2021-09-30' as date)"
   )
}})

select * from all_days
