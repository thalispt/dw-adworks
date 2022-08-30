with reason as (
    select
        salesreasonid
        , name as reason_name
        , reasontype
    from {{ source('adventure_works_erp', 'sales_salesreason') }}
)

select *
from reason