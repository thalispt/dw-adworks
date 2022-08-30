with source_data as (
    select
        businessentityid
        , creditcardid
    from {{source('adventure_works_erp','sales_personcreditcard')}}
)

select *
from source_data