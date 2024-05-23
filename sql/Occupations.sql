-- pivot syntax
SELECT
    *
FROM
    (
        SELECT
            column1,
            column2
        FROM
            tables
        WHERE
            conditions
    ) PIVOT (
        aggregate_function(column2) FOR column2 IN (expr1, expr2,...expr_n) | subquery
    )
ORDER BY
    expression [ ASC | DESC ];

select
    *
from
    (
        select
            name,
            occupation
        from
            occupations
    ) pivot (
        count(occupations) for occupation in ('Doctor', 'Professor', 'Singer', 'Actor')
    )
order by
    name;

-- Answer
select
    doctor,
    professor,
    singer,
    actor
from
    (
        select
            name,
            occupation,
            -- adding rank column so that the result will be the max of name within name, occupation and rank,
            -- if the rank is not included, the columns will be only name, and occupation
            -- then the max of data will be only a single row.
            row_number() over(
                partition by occupation
                order by
                    name asc
            ) rn
        from
            occupations
    ) pivot (
        max(name) for occupation in (
            'Doctor' as doctor,
            'Professor' as professor,
            'Singer' as singer,
            'Actor' as actor
        )
    )
order by
    rn;