select 
    h.hacker_id, 
    h.name,
    count(c.hacker_id) as no_of_challenges
from hackers h
inner join challenges c
on h.hacker_id = c.hacker_id
-- get all hacker_id with max no of challenges completed
having count(c.hacker_id) = (
    select 
        max(count(c1.hacker_id)) as max_challenges
    from challenges c1
    group by c1.hacker_id
) 
or  count(c.hacker_id) in (
    select 
        t1.cnt
        from (
            -- getting no of challenges done by each hackers
            select 
                c2.hacker_id,
                count(c2.hacker_id) as cnt 
            from challenges c2
            group by c2.hacker_id
        ) t1
        group by t1.cnt
        having count(t1.cnt) = 1 -- selecting unique count value
        order by t1.cnt asc
    )
group by h.hacker_id, h.name
order by no_of_challenges desc, hacker_id asc;