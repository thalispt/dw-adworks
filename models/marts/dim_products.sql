with products as (
    select 
        productid
        , productcategoryid		
        , product
        , product_number	
        , color		
        , standard_cost
        , list_price
        , size
        , weight 
        , sell_start_date
        , sell_end_date
    from {{ ref('stg_product') }}
)

, productcategory as (
    select 
        productcategoryid
        , category
    from {{ ref('stg_productcategory')}}
)
, transformed as (
    select  
        row_number() over (order by productid) as product_sk -- incremental surrougate key
        , products.productid		
        , products.product
        , productcategory.category
        , products.product_number	
        , products.color		
        , products.standard_cost
        , products.list_price
        , products.size
        , products.weight 
        , products.sell_start_date
        , products.sell_end_date
        from products
    left join productcategory on products.productcategoryid = productcategory.productcategoryid
)

select * 
from transformed
