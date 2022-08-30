with customers as (

    select
        customerid
        , personid
        , storeid
        , territoryid				
    from {{ref ('stg_customer')}}
    where personid != 0

)
, person as (
    select
        businessentityid
        , persontype
        , full_name    
    from {{ref ('stg_person')}}
)

, transformed as (
    select
        row_number() over (order by customerid) as customer_sk -- auto-incremental surrogate key
        , customers.customerid
        , customers.storeid
        , person.businessentityid
        , person.full_name
    from customers
    left join person on person.businessentityid = customers.personid
)

select * from transformed