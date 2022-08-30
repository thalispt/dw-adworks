with source_data as (
    select
        salesorderid
        , max(salesreasonid) as salesreasonid
    from {{source('adventure_works_erp','sales_salesorderheadersalesreason')}}
    group by salesorderid
)
    , concatenate_source as (
        select
           source_data.salesorderid
            , source_data.salesreasonid
            , concat(salesorderid, '',salesreasonid) as orderreasonid
        from source_data
    )

select *
from concatenate_source