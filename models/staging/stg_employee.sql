with source_data as (
select
    businessentityid		
    , nationalidnumber
    , loginid
    , jobtitle
    , birthdate	
    , maritalstatus
    , gender
    , hiredate	
    , salariedflag
    , vacationhours		
    , sickleavehours		
    , currentflag
from {{ source('adventure_works_erp', 'hr_employee') }}
)

select *
from source_data