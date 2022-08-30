with sales_order_header_source as (
select
    salesorderid
    , revisionnumber		
    , orderdate		
    , duedate		
    , shipdate		
    , status		
    , onlineorderflag		
    , purchaseordernumber		
    , accountnumber		
    , customerid		
    , salespersonid		
    , territoryid		
    , billtoaddressid		
    , shiptoaddressid		
    , shipmethodid		
    , creditcardid		
    , creditcardapprovalcode		
    , currencyrateid		
    , subtotal		
    , taxamt		
    , freight		
    , totaldue				
from {{ source('adventure_works_erp', 'sales_salesorderheader') }}
)

, sales_reason as (
    select
        sales_order_header_source.*
        , salesreasonid
    from sales_order_header_source
    left join {{ source('adventure_works_erp', 'sales_salesorderheadersalesreason') }} as sales_reason on sales_order_header_source.salesorderid = sales_reason.salesorderid
)
select *
from sales_reason