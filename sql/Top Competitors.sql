-- mySolution

select
    h_id,
    h_name
from ( -- #memo: this isnt necessary
    select
      h.hacker_id as h_id,
      h.name as h_name,
      count(*) as no_of_full_marks
    from
      submissions s
      inner join hackers h on s.hacker_id = h.hacker_id
      inner join challenges c on s.challenge_id = c.challenge_id
      inner join difficulty d on d.difficulty_level = c.difficulty_level
    where
      d.score = s.score
    group by
      h.hacker_id,
      h.name
  ) t
  where
  no_of_full_marks > 1
order by
  no_of_full_marks desc,
  h_id asc;

-- This is better!!!

SELECT h.hacker_id,
       h.name
FROM   hackers h
       join submissions s
         ON h.hacker_id = s.hacker_id
       join difficulty d
         ON s.score = d.score
       join challenges c
         ON s.challenge_id = c.challenge_id
            AND d.difficulty_level = c.difficulty_level
GROUP  BY h.hacker_id,
          h.name
HAVING Count(s.submission_id) > 1 -- use count() in having clause to avoid unnecessary subquery...
ORDER  BY Count(s.submission_id) DESC,
          hacker_id ASC;  