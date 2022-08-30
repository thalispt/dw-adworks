with source_data as (
select
    addressid		
    , addressline1 as address_ref
    , city	
    , stateprovinceid		
    , postalcode	
from {{ source('adventure_works_erp', 'person_address') }}
)

select *
from source_data