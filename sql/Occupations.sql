
-- pivot syntax
SELECT * FROM
(
  SELECT column1, column2
  FROM tables
  WHERE conditions
)
PIVOT 
(
  aggregate_function(column2)
  FOR column2
  IN ( expr1, expr2, ... expr_n) | subquery
)
ORDER BY expression [ ASC | DESC ];



select
    *
from
    (
        select
            name,
            occ
    )
from
    occupations;