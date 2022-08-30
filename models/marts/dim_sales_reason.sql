with staging as (

    select 
        salesreasonid
        , reason_name
        , reasontype
    from {{ ref('stg_salesreason') }}
)
, transformed as (
    select 
        row_number () over (order by salesreasonid) as reason_sk -- chave surrogate auto incremental
        , *
    from staging
)

select *
from transformed