-- based on the colleage database, and answer the following questions:
-- 1. Find the titles of courses in the Comp. Sci. department that have 3 credits.

select title 
from course
where dept_name='Comp. Sci.' and credits=3;


--2. Find the highest salary of any instructor.

select max(salary) as highest_salary
from instructor;

-- 3. Find all instructors earning the highest salary
-- (there may be more than one with the same salary).

select name
from instructor 
where salary= (select max(salary)
				from instructor);

-- 4. Find the enrollment of each section that was offered in Fall 2018.
select course_id, sec_id, count(*) as enrollment
from takes
where semester='Fall' and year='2018'
group by course_id, sec_id;

-- 5. Find the maximum enrollment, across all sections, in Fall 2018.

select max(enrollment) as max_enrollment
from
(select course_id, sec_id, count(*) as enrollment
from takes
where semester='Fall' and year='2018'
group by course_id, sec_id) t
;

-- 6. Find the course id and section that had the maximum enrollment in Fall 2018.

with max_enrollment (course_id, sec_id, enrollment) as 
(select course_id, sec_id, count(*)									
from takes
where semester='Fall' and year='2017'
group by course_id, sec_id)
select course_id, sec_id
from max_enrollment
where enrollment=(select max(enrollment) from max_enrollment);
;

-- 7. Find the ID and name of each student who has taken at least three Comp. Sci. course; 
-- make sure there are no duplicate names in the result.

select student.id, student.name, count(*) number_of_courses
from student, takes, course
where student.id=takes.id and
    takes.course_id=course.course_id and course.dept_name='Comp. Sci.'
group by student.id, student.name
having count(*)>=3;

-- 8. Find the ID and name of each student who has not taken any course offered before 2018.
select student.id, student.name
from student, takes
where student.ID=takes.ID and takes.course_id not in (select distinct course_id
													  from takes
													  where year<2018);
													  
-- 9. For each department, find the instructor with the highest salary in that department. 
-- You may assume that every department has at least one instructor.

with highest_salary_by_dept (dept_name, highest_salary) as
(select dept_name, max(salary)
from instructor
group by dept_name)
select name, dept_name, salary
from instructor 
where salary= (select highest_salary
			  from highest_salary_by_dept h
			  where h.dept_name=instructor.dept_name);


-- option 2 use rank function
-- RANK() function is a window function that assigns a unique rank to each distinct row
-- within a partition of a result set. 

select *
from 
(select name, dept_name, salary, 
            rank() over (partition by dept_name order by salary desc) as rank
from instructor) t
where rank=1;

-- 10. Find the lowest, across all departments, 
-- of the per-department maximum salary computed by the preceding query.

select *
from 
(select name, dept_name, salary, 
            rank() over (partition by dept_name order by salary) as rank
from instructor) t
where rank=1;