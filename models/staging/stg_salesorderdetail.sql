with source_data as (
select
  salesorderid		
    , salesorderdetailid		
    , orderqty		
    , productid		
    , unitprice		
    , unitpricediscount	
from {{ source('adventure_works_erp', 'sales_salesorderdetail') }}
)

select *
from source_data