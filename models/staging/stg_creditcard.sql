with source_data as (

    select
        creditcardid
        , cardtype
        , cardnumber
        , expmonth
        , expyear
    from {{source('adventure_works_erp','sales_creditcard')}}
)

select *
from source_data