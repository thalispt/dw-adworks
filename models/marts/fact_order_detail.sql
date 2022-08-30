with customers as (
    select
        customer_sk
        , customerid
    from {{ref('dim_customer')}}
)

, products as (
    select
        product_sk
        , productid
    from {{ref('dim_products')}}
)

, location as (
    select
        location_sk
        , addressid
    from {{ref('dim_location')}}
)

,  employees as (
    select
        employee_sk
        , businessentityid
    from {{ref('dim_employee')}} 
)

, sales_reason as (
    select
        reason_sk
        , salesreasonid
    from {{ref('dim_sales_reason')}}
)

, creditcard as (
    select
        creditcard_sk
        , creditcardid
    from {{ref('dim_creditcard')}}
)

, full_sales_orders_details as (
    select
        fullsalesorderdtl.salesorderid
        , customers.customer_sk as customer_fk
        , employees.employee_sk as employee_fk
        , location.location_sk as location_fk
        , case 
            when sales_reason.reason_sk is null then 10
            else sales_reason.reason_sk
        end as reason_fk
        , creditcard.creditcard_sk as creditcard_fk	
        , fullsalesorderdtl.customerid		
        , fullsalesorderdtl.territoryid
        , fullsalesorderdtl.salespersonid	
        , fullsalesorderdtl.billtoaddressid		
        , fullsalesorderdtl.shiptoaddressid		
        , fullsalesorderdtl.creditcardid
        , fullsalesorderdtl.orderdate		
        , fullsalesorderdtl.duedate		
        , fullsalesorderdtl.shipdate		
        , fullsalesorderdtl.status		
        , fullsalesorderdtl.onlineorderflag		
        , fullsalesorderdtl.purchaseordernumber		
        , fullsalesorderdtl.accountnumber			
        , fullsalesorderdtl.creditcardapprovalcode		
    from {{ref('stg_sales_salesorderheaders')}} as fullsalesorderdtl
    left join customers on fullsalesorderdtl.customerid = customers.customerid
    left join employees on fullsalesorderdtl.salespersonid = employees.businessentityid
    left join location on fullsalesorderdtl.shiptoaddressid = location.addressid
    left join sales_reason on fullsalesorderdtl.salesreasonid = sales_reason.salesreasonid
    left join creditcard on fullsalesorderdtl.creditcardid = creditcard.creditcardid
)

, order_dtl as (
    select 
    order_detail.salesorderid		
    ,order_detail.salesorderdetailid
    , products.product_sk as product_fk		
    , order_detail.orderqty				
    , order_detail.unitprice		
    , order_detail.unitpricediscount	
    from {{ref('stg_salesorderdetail')}} order_detail
    left join products on order_detail.productid = products.productid
)

, final_fact as (
    select
        fullsalesorderdtl.salesorderid
        , fullsalesorderdtl.customer_fk
        , fullsalesorderdtl.employee_fk
        , fullsalesorderdtl.location_fk
        , order_dtl.product_fk
        , fullsalesorderdtl.reason_fk
        , fullsalesorderdtl.creditcard_fk		
        , fullsalesorderdtl.billtoaddressid		
        , fullsalesorderdtl.shiptoaddressid
        , fullsalesorderdtl.orderdate		
        , fullsalesorderdtl.duedate		
        , fullsalesorderdtl.shipdate		
        , fullsalesorderdtl.status		
        , fullsalesorderdtl.onlineorderflag		
        , fullsalesorderdtl.purchaseordernumber		
        , fullsalesorderdtl.accountnumber			
        , fullsalesorderdtl.creditcardapprovalcode		
        , order_dtl.orderqty		
        , order_dtl.unitprice		
        , order_dtl.unitpricediscount		
    from full_sales_orders_details fullsalesorderdtl
    left join order_dtl on fullsalesorderdtl.salesorderid = order_dtl.salesorderid
   
)

select *
from final_fact