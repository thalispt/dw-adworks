with source_data as (
select
    customerid
    , personid
    , storeid
    , territoryid
from {{ source('adventure_works_erp', 'sales_customer') }}
)

select *
from source_data