with source_data as (
select
    customerid		
    , addressid		
    , addresstype		
from {{ source('adventure_works_erp', 'public_customeraddress') }}
)

select *
from source_data