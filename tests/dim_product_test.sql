with validation as (
    select 
        count(productid) as total
    from {{ ref ('dim_products')}}
    where  product = 'HL Fork' and productid = 804
)

select * from validation where total != 1