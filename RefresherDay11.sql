select top (1000) * from [dbo].[FactCallCenter];

select COUNT(*) as TotalWeekdays from [dbo].[FactCallCenter]
where not WageType='holiday';

select COUNT(*) as TotalHolidays from [dbo].[FactCallCenter]
where not WageType='weekday';


select * from [dbo].[FactCallCenter]
where not WageType='weekday' AND not Shift='midnight';

select * from [dbo].[FactCallCenter]
where WageType != 'weekday' AND Shift !='midnight'
order by Calls DESC, Shift DESC;


select * from [dbo].[DimEmployee] as em
where em.BirthDate like '____-__-%4%';


select * from [dbo].[DimEmployee] as em
where em.EmailAddress like '%Walters%@adventure-works.com';

select 
em.FirstName,
em.LastName,
em.SickLeaveHours 
from [dbo].[DimEmployee] as em
where em.SickLeaveHours =(select MAX(SickLeaveHours) from [dbo].[DimEmployee]);


select 
em.FirstName,
em.LastName,
em.SickLeaveHours 
from [dbo].[DimEmployee] as em
where em.SickLeaveHours =(select MAX(SickLeaveHours) from [dbo].[DimEmployee]) 
or em.VacationHours =(select MIN(VacationHours) from [dbo].[DimEmployee]);


select * from [dbo].[DimEmployee] as em
where em.DepartmentName in ('Tool Design','Engineering');


select AVG(BaseRate) as AverageRateEngrs from [dbo].[DimEmployee] as em
where em.DepartmentName in ('Tool Design','Engineering');

select AVG(BaseRate) as AverageRateOO from [dbo].[DimEmployee] as em
where em.DepartmentName in ('Marketing','Finance');


declare @averageBaseRateEngr int
declare @averageBaseRateOO int

set @averageBaseRateEngr = (select AVG(BaseRate) as AverageRateEngrs from [dbo].[DimEmployee] as em
where em.DepartmentName in ('Tool Design','Engineering'))

set @averageBaseRateOO = (select AVG(BaseRate) as AverageRateOO from [dbo].[DimEmployee] as em
where em.DepartmentName in ('Marketing','Finance'))

declare @differences int = @averageBaseRateEngr - @averageBaseRateOO

print @differences

select top (500) * from [dbo].[DimCustomer];
select top (1000) * from [dbo].[FactInternetSales];
select top (10) * from [dbo].[DimGeography]

select 
cus.FirstName + ' '+ cus.LastName as fullname,
cus.BirthDate,
cus.AddressLine1,
cus.Gender,
cus.MaritalStatus,
cus.GeographyKey,
cus.YearlyIncome,
Geo.City,
Geo.EnglishCountryRegionName

into GermanyCustomers2 from
[dbo].[DimCustomer] as cus
inner join [dbo].[DimGeography] as Geo
on cus.GeographyKey = Geo.GeographyKey
where geo.EnglishCountryRegionName = 'Germany';

select * from GermanyCustomers2;
select count(*) DEcustomers from GermanyCustomers2