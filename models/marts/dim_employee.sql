with person as (
    select 
        businessentityid
        , full_name
    from {{ref('stg_person') }}
)

,  salesperson as (
    select 
        businessentityid
        , salesquota
        , bonus
        , commissionpct
        , salesytd
        , saleslastyear
    from {{ref('stg_salesperson') }}
)

, employee as (
    select 
        businessentityid 
        , jobtitle
        , hiredate
        , gender	
        , birthdate       
    from {{ref('stg_employee')}}

)
, transformed as (
    select
        row_number() over (order by salesperson.businessentityid) as employee_sk -- incremental surrougate key
        , employee.businessentityid
        , salesperson.salesquota
        , salesperson.bonus		
        , salesperson.commissionpct		
        , salesperson.salesytd		
        , salesperson.saleslastyear
        , person.full_name
        , employee.jobtitle
        , employee.birthdate	
        , employee.gender
        , employee.hiredate	
    from salesperson 
    left join person on salesperson.businessentityid = person.businessentityid
    left join employee on salesperson.businessentityid = employee.businessentityid
)

select *
from transformed