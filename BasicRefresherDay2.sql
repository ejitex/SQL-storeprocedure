Use AdventureWorks2019;

select top 100 * from HumanResources.Department;
select top 100 * from HumanResources.Employee;

-- Group by cube allows you to specific multiple columns to group by
--1st cube method
Select JobTitle, Gender, Sum(SickLeaveHours) as Total_sickLeaveHours from
HumanResources.Employee
group by cube(JobTitle, Gender);

-- 2nd cube method
Select JobTitle, Gender, Sum(SickLeaveHours) from
HumanResources.Employee
group by JobTitle, Gender with cube;

-- 3rd cube Method 
Select JobTitle, Gender, Sum(SickLeaveHours) from
HumanResources.Employee
group by 
	  grouping sets ((JobTitle, Gender),
						(JobTitle),
						(Gender));

select top 100 * from Production.Product;
select top 100 * from Production.ProductInventory;


Select top 100 * from Sales.SalesOrderDetail;
Select top 100 * from Sales.SalesPerson;
Select top 100 * from Person.Person;
Select top 100 * from Person.PersonPhone;

--List of products with enough stocklevel

Select P.Name, ListPrice, P.SafetyStockLevel, I.Quantity from Production.Product as P
inner join Production.ProductInventory as I
on P.ProductID = I.ProductID
where I.Quantity > P.SafetyStockLevel;

--List of products with quantity less than required stock level
Select P.Name, ListPrice, P.SafetyStockLevel, I.Quantity from Production.Product as P
inner join Production.ProductInventory as I
on P.ProductID = I.ProductID
where I.Quantity < P.SafetyStockLevel;

-- Get John Smith phone number
Select cus.FirstName +' '+ cus.LastName as Fullname, tel.PhoneNumber from Person.Person as cus
inner join Person.PersonPhone as tel
on cus.BusinessEntityID = tel.BusinessEntityID
where cus.FirstName = 'John' and cus.LastName = 'Smith';


-- Stored Precedure

create procedure GetPhone @Firstname nvarchar(30), @Lastname nvarchar(30) 
AS
Select cus.FirstName +' '+ cus.LastName as Fullname, tel.PhoneNumber from Person.Person as cus
inner join Person.PersonPhone as tel
on cus.BusinessEntityID = tel.BusinessEntityID
where cus.FirstName = @Firstname and cus.LastName = @Lastname;

GO

exec GetPhone @Firstname = 'Gail', @Lastname = 'Erickson'


select top 100 * from HumanResources.Employee;

-- Union All and varibales declaraion

declare @NumDesignEngr int
declare @NumToolDesigner int
declare @NumMktSpec int

Set @NumDesignEngr = (Select count(*)from HumanResources.Employee
where JobTitle = 'Design Engineer')

Set @NumToolDesigner = (Select count(*)from HumanResources.Employee
where JobTitle = 'Tool Designer')

Set @NumMktSpec = (Select count(*)from HumanResources.Employee
where JobTitle = 'Marketing Specialist')

Print 'Number of Design Engineer  : ' +  cast(@NumDesignEngr as varchar(max))
Print 'Number of Tool Designer: ' +  cast(@NumToolDesigner as varchar(max))
Print 'Number of Marketing Specialist : ' +  cast(@NumMktSpec as varchar(max));

Select NationalIDNumber, JobTitle, Gender 
from HumanResources.Employee
where JobTitle = 'Design Engineer'
 
 Union All

Select NationalIDNumber, JobTitle, Gender 
from HumanResources.Employee
where JobTitle = 'marketing Specialist'

Union All

Select NationalIDNumber, JobTitle, Gender 
from HumanResources.Employee
where JobTitle = 'Tool Designer';

Select @@SERVERNAME as Servername;

-- Group by and Having 
select PP.ProductID,PP.Name, 
AVG(PPH.ListPrice) as AverageChangePrice
--count(*) as NumTimesChanged
from Production.Product PP
  inner join Production.ProductListPriceHistory as PPH
on PP.ProductID = PPH.ProductID
group by PP.ProductID, PP.Name
--having AVG(PPH.ListPrice) >= 100
-- order by AVG(PPH.ListPrice) desc;
order by count(*) desc; -- using aggregate function on order by


select PP.ProductID, PP.Name, 
SUM(PPH.ListPrice) as AverageChangePrice
--count(*) as NumTimesChanged
from Production.Product PP
  inner join Production.ProductListPriceHistory as PPH
on PP.ProductID = PPH.ProductID
group by PP.ProductID, PP.Name
--having AVG(PPH.ListPrice) >= 100
-- order by AVG(PPH.ListPrice) desc;
order by count(*) desc; -- using aggregate function on order by


-- check orders Sales.SalesOrderDetail with product tables

Select * from Production.ProductListPriceHistory
where ProductID = 712;



Select P.Name, ListPrice, P.SafetyStockLevel, I.Quantity from Production.Product as P
inner join Production.ProductInventory as I
on P.ProductID = I.ProductID
where I.Quantity < P.SafetyStockLevel;

select * from HumanResources.Employee;
-- Subquery
-- exmaple 1
select NationalIDNumber, JobTitle, SickLeaveHours from HumanResources.Employee
where SickLeaveHours = (select Max(SickLeaveHours) as Max_SickLeaver 
from HumanResources.Employee);

-- example 2 - employees with above average sickleaves
select PP.FirstName + ' '+ PP.LastName as Fullname, emp.NationalIDNumber, emp.JobTitle, emp.VacationHours, emp.SickLeaveHours 
from HumanResources.Employee as emp
inner join Person.Person as PP
on emp.BusinessEntityID = PP.BusinessEntityID
where SickLeaveHours >= (select AVG(SickLeaveHours) as Max_SickLeaver 
from HumanResources.Employee)
order by Fullname ASC;

-- No error but didn't work as expected.
select NationalIDNumber, JobTitle, SickLeaveHours from HumanResources.Employee
where VacationHours >= (select avg(SickLeaveHours) as Max_SickLeaver 
from HumanResources.Employee 
where JobTitle = 'Janitor');

select * from Person.Person;

-- create index

Create index Person_firstnames_idx
on Person.Person(FirstName);

Select count(*) as CountDavids from Person.Person
where FirstName = 'David';