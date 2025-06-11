-- Qn 1. Find the Top 3 Highest Paid Employees in Each Department
-- For every department, list the top 3 employees with the highest salary. If a department has fewer than 3 employees, list all of them

-- my ans
select 
    t1.employee_id
    , t1.first_name || ' ' || t1.last_name as full_name
    , t1.department_name
    , t1.rank
    from (
        select 
            e.employee_id 
            , e.first_name 
            , e.last_name 
            , d.department_name
            , e.department_id
            , rank() over(partition by e.department_id order by e.salary desc) as rank
        from 
            oehr_employees e
        inner join 
            oehr_departments d
        on e.department_id = d.department_id
    ) t1
    where 
        t1.rank <= 3
    order by t1.department_id, t1.rank;