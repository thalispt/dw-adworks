with stateprovince as (
    select
         stateprovinceid		
        , stateprovincecode		
        , countryregioncode	
        , state_name
        , territoryid		
    from {{ ref('stg_stateprovince') }}
)

, address_final as (
        select 		
        addressid		
        , address_ref
        , city	
        , stateprovinceid		
        , postalcode			
    from {{ ref('stg_address') }}
)

, countryregion as (
    select
        countryregioncode
        , country 
    from {{ ref('stg_countryregion') }}
)

, transformed as (
    select 
        row_number() over (order by addressid) as location_sk -- incremental surrougate key
        , address_final.addressid
        , address_final.stateprovinceid	
        , address_final.address_ref	
        , address_final.postalcode
        , case 
            when address_final.city is null then stateprovince.state_name || ' City'
            else address_final.city
        end as city
        , stateprovince.state_name
        , stateprovince.stateprovincecode	
        , countryregion.country
    from address_final
   left join stateprovince on address_final.stateprovinceid = stateprovince.stateprovinceid
   left join countryregion on stateprovince.countryregioncode = countryregion.countryregioncode
)


select * 
from transformed