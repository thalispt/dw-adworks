with validation as (
    select
        sum(unitprice) as total
    from {{ ref ('fact_order_detail') }}
    where orderdate between '2012-12-01' and '2012-12-31' )

select * from validation where total != 1257847.1713999873