with source_data as (
select
   businessentityid
    , territoryid		
    , salesquota
    , bonus		
    , commissionpct		
    , salesytd		
    , saleslastyear		
from {{ source('adventure_works_erp', 'sales_salesperson') }}
)

select *
from source_data