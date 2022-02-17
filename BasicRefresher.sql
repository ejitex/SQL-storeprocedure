Use CApublicSchoolsDB;

select top 5 Percent * from Schools;
select top 20 percent * from Board;

select distinct Sch_Level from Schools;

-- 709 elementary school with more than 500 enrollment
select count(*) as Total_elementary 
from Schools
where Sch_Level = 'Elementary' and Enrollment >= 500;

select *
from Schools
where Sch_Level = 'Elementary' and Enrollment >= 500
order by Sch_Name ASC;


Select count(*) as Missing_value from Schools
where Enrollment is null;

Select AVG(Enrollment) as average_enrollment from Schools;

-- replace null value in Enrollment with average enrollment. Good option will be to write a statment that calculates the average and do the replacement
update Schools 
set Enrollment = 418
where Enrollment is null;

-- min enrollment in Elementary schools

Select min(Enrollment) as MIN_enroll 
from Schools
where Sch_Level = 'Elementary'


Select max(Enrollment) as MAX_enroll from Schools; 

Select *
from Schools
where Enrollment = 10;

--LIKE Operator	Description
--WHERE CustomerName LIKE 'a%'	Finds any values that start with "a"
--WHERE CustomerName LIKE '%a'	Finds any values that end with "a"
--WHERE CustomerName LIKE '%or%'	Finds any values that have "or" in any position
--WHERE CustomerName LIKE '_r%'	Finds any values that have "r" in the second position
--WHERE CustomerName LIKE 'a_%'	Finds any values that start with "a" and are at least 2 characters in length
--WHERE CustomerName LIKE 'a__%'	Finds any values that start with "a" and are at least 3 characters in length
--WHERE ContactName LIKE 'a%o'	Finds any values that start with "a" and ends with "o"

--  Symbol	Description												Example
--  %	   Represents zero or more characters						bl% finds bl, black, blue, and blob
--  _	   Represents a single character							h_t finds hot, hat, and hit
--  []	   Represents any single character within the brackets		h[oa]t finds hot and hat, but not hit
--  ^	   Represents any character not in the brackets				h[^oa]t finds hit, but not hot and hat
--  -	   Represents a range of characters							c[a-b]t finds cat and cbt

select * from Schools
where Sch_Name like 'hunt%';


-- 'IN' in where clause statement

Select * from Schools
where Enrollment between 800 and 2251;

-- Inner joint or default join statement which returns only rows where the ID matches in both tables
-- https://www.youtube.com/watch?v=9yeOJ0ZMUYw

Select Schools.B_ID, Board.B_name, Board.Sch_Type from Schools
inner join Board on Schools.B_ID = Board.B_ID
where Board.Sch_Type = 'Roman Catholic';

-- Left join returns all rows from left table even if there is no matching row in right table. 
Select * from Schools as left_table
left join Board as right_table on left_table.B_ID = right_table.B_ID

-- Right join returns all rows from right table even if there is no matching row in left table. OPPOSITE OF LEFT JOIN

Select * from Schools as left_table
right join Board as right_table on left_table.B_ID = right_table.B_ID


Select Schools.B_ID, SUM(Schools.Enrollment), Board.B_name, Board.Sch_Type from Schools
inner join Board on Schools.B_ID = Board.B_ID
where Board.Sch_Type = 'Roman Catholic'


-- Group by cube

Select Sch_ID, Sch_name, Sum(Enrollment) as Total_enrollment
from Schools
group by cube(B_ID,Sch_Level);