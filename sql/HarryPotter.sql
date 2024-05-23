
-- ToDo:
id age coins_needed power_of_the_wands
9  45     1647             10



select 
    w.id,
    w.coins_needed,
    w.power,
    wp.age
from
wands w
inner join wands_property wp
on w.code = wp.code
where wp.is_evil = 0
order by w.power desc, wp.age desc;



select 
  w.id,
    w.coins_needed,
    w.power,
    wp.age
from (
    select 
    wp.age, w.power
    from wands w
    inner join wands_property wp
    on w.code = wp.code
    group by wp.age, w.power
) t1
inner join wands_property wp
on w.code = wp.code
group by wp.age, w.power



select    
t2.id,
t2.code,
t1.power
from     
(    
    select     
        code,    
        max(power) as power,
        min(coins_needed) as coins_needed
    from wands    
    group by code    
    order by code    
) t1    
inner join wands t2    
on t1.code = t2.code    
and t1.power = t2.power 
order by code asc
;


/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/



--     select 
--         code,
--         max(power)
--     from wands
--     group by code
--     order by code
--     ;

select    
    t2.id,
    t3.age,
    t1.coins_needed,
    -- t2.code,
    t1.power
from     
(    -- max power with min price
    select     
        code,    
        max(power) as power,
        min(coins_needed) as coins_needed
    from wands    
    group by code    
    order by code    
) t1    
inner join wands t2    
on t1.code = t2.code    
and t1.power = t2.power 
and t1.coins_needed = t2.coins_needed
inner join wands_property t3
on t1.code = t3.code
where t3.is_evil = 0
order by t1.power desc, t3.age desc
;
-- select 
-- *
-- from wands_property;