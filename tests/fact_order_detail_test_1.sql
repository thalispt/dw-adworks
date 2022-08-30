with validation as (
    SELECT
    count(distinct salesorderid ) as pedidos
    FROM {{ ref ('fact_order_detail') }}
    WHERE orderdate between '2011-01-31' and '2014-06-30' 
)

select * from validation where pedidos != 31465