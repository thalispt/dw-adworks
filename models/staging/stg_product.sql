with source_data as (
select
    productid
    , productcategoryid					
    , name as product
    , productnumber as product_number	
    , color		
    , standardcost	as standard_cost
    , listprice as list_price
    , size
    , weight 
    , sellstartdate as sell_start_date
    , sellenddate	as sell_end_date
from {{ source('adventure_works_erp', 'public_product') }}
)

select *
from source_data