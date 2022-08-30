 with source_data as (
select
    stateprovinceid		
    , stateprovincecode		
    , countryregioncode
    , name as state_name
    , territoryid		
    , rowguid		
    , modifieddate
from {{ source('adventure_works_erp', 'person_stateprovince') }}
)

select *
from source_data

 