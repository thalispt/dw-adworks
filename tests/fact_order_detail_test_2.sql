with validation as (
    select
        cast(sum(unitprice) as int) as total
    from {{ ref ('fact_order_detail') }}
    where orderdate between '2012-12-01' and '2012-12-31' )

select * from validation where total != 1257847