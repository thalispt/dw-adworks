with creditcard as (

    select
        creditcardid
        , cardtype
        , cardnumber				
    
    from {{ ref('stg_creditcard') }} 	

)
    , personcreditcard as (
        select
            businessentityid
            , creditcardid			
    
        from {{ ref('stg_personcreditcard') }}
    )
    , transformed as (
        select
            row_number() over (order by creditcard.creditcardid) as creditcard_sk -- auto-incremental surrogate key
            , creditcard.creditcardid
            , creditcard.cardtype
            , creditcard.cardnumber
            , personcreditcard.businessentityid

        from creditcard
            left join personcreditcard
                on personcreditcard.creditcardid = creditcard.creditcardid

)

select  * from transformed