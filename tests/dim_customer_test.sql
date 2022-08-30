with validation as (
    select
        count(customerid) as total
    from {{ ref ('dim_customer') }}
    where full_name = 'Julia Nelson' AND customerid = 11102
)

select * from validation where total != 1