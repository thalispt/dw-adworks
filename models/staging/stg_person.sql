with source_data as (
select
    businessentityid		
    , persontype	
    , namestyle
    , firstname	|| ' ' || lastname as full_name
from {{ source('adventure_works_erp', 'person_person') }}
)

select *
from source_data