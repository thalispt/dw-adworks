with source_data as (
select
     countryregioncode
     , name as country
from {{ source('adventure_works_erp', 'person_countryregion') }}
)

select *
from source_data