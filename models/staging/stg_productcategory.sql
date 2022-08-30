with source_data as (
select
    productcategoryid		
    , parentproductcategoryid		
    , name as category
from {{ source('adventure_works_erp', 'public_productcategory') }}
)

select *
from source_data