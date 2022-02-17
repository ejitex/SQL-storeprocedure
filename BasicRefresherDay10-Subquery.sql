-- Example 1: Sub-query statement Find employee with highest pay rate

Select PP.FirstName + ' '+ PP.LastName as Fullname, EPH.Rate from [HumanResources].[EmployeePayHistory] as EPH
inner join [Person].[Person] as PP
on EPH.BusinessEntityID = PP.BusinessEntityID
where Rate = (Select max(Rate) from[HumanResources].[EmployeePayHistory]);

-- confirm your result is correct.
Select * from [Person].[Password];

-- Row_number + parition function is use to generate serial number on the go!

-- example 1
Select row_number() over (order by PasswordSalt) as SerialNumber, 
PP.FirstName +' '+ PP.LastName as Fullname,
Pass.PasswordHash, 
Pass.PasswordSalt 
from [Person].[Password] as Pass
inner join [Person].[Person] as PP
on Pass.BusinessEntityID = PP.BusinessEntityID;

-- example 2 with partition

--select * from [HumanResources].[EmployeeDepartmentHistory];
--select * from [Person].[Person];

Select row_number() over (order by FirstName) as PersonSerialNumber, 
	   row_number() over ( partition by DepartmentID order by DepartmentID) as DepartmentSerialNumber,
	   PP.FirstName +' '+ PP.LastName as fullname,
	   HRE.DepartmentID,
	   HRE.StartDate
from [Person].[Person] as PP
inner join [HumanResources].[EmployeeDepartmentHistory] as HRE
on PP.BusinessEntityID = HRE.BusinessEntityID;


-- Rank function generates unique number for the same data
-- example 3 maybe not the best example but get the idea

Select row_number() over (order by FirstName) as PersonSerialNumber, 
	   row_number() over ( partition by DepartmentID order by DepartmentID) as DepartmentSerialNumber,
	   RANK() over (order by DepartmentID) as DepID,
	   PP.FirstName +' '+ PP.LastName as fullname,
	   HRE.DepartmentID,
	   HRE.StartDate
from [Person].[Person] as PP
inner join [HumanResources].[EmployeeDepartmentHistory] as HRE
on PP.BusinessEntityID = HRE.BusinessEntityID;

-- Dense_Rank function generates unique number for the same data in a squential manner
Select row_number() over (order by FirstName) as PersonSerialNumber, 
	   row_number() over ( partition by DepartmentID order by DepartmentID) as DepartmentSerialNumber,
	   Dense_RANK() over (order by DepartmentID) as DepID, --this should be identical with DepartmentID
	   PP.FirstName +' '+ PP.LastName as fullname,
	   HRE.DepartmentID,
	   HRE.StartDate
from [Person].[Person] as PP
inner join [HumanResources].[EmployeeDepartmentHistory] as HRE
on PP.BusinessEntityID = HRE.BusinessEntityID;

-- Joining Three tables

select * from [Person].[Person];
select * from [HumanResources].[Employee];
select * from [HumanResources].[EmployeeDepartmentHistory];

create procedure spEmployeeStartDate @GreaterEqualStartDate Date

as

Select 
ROW_NUMBER() over (order by FirstName) as 'S/No',

LTable.FirstName+ ' ' + LTable.LastName as Fullname,
RTable.JobTitle,
RTable.BirthDate,
RTable2.StartDate
from  [Person].[Person] as LTable
inner join [HumanResources].[Employee]  as RTable
on LTable.BusinessEntityID = RTable.BusinessEntityID
inner join[HumanResources].[EmployeeDepartmentHistory]  as RTable2
on LTable.BusinessEntityID = RTable2.BusinessEntityID
where RTable2.StartDate >= @GreaterEqualStartDate
order by RTable2.StartDate DESC;

-- Store Procedure in its simple form
create procedure usp_GetDate @numberofdaysBefore int
as
Select GETDATE() - @numberofdaysBefore;

-- substracts 78 days from the current date
exec usp_GetDate 78


alter procedure usp_GetDateAfter @numberofdaysAfter int
as
Select GETDATE() + @numberofdaysAfter as xDateafter;

exec usp_GetDateAfter 1

exec spEmployeeStartDate '2013-05-28'


-- Using store procedure to insert

create procedure spINSERTPersonTable
  @BusinessEntityID int,
      @PersonType nchar(2),
      @NameStyle bit
      ,@Title nvarchar(8)
      ,@FirstName nvarchar(50)
      ,@MiddleName nvarchar(50)
      ,@LastName nvarchar(50)
      ,@Suffix nvarchar(10)
      , @EmailPromotion int
      , @AdditionalContactInfo xml
      ,@Demographics xml
      ,@rowguid uniqueidentifier
      ,@ModifiedDate datetime

	  as
	  Insert into [AdventureWorks2019].[Person].[Person](
	  [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[rowguid]
	  ,[ModifiedDate]
	  )
	values(
	@BusinessEntityID
      ,@PersonType
      ,@NameStyle 
      ,@Title 
      ,@FirstName 
      ,@MiddleName 
      ,@LastName 
      ,@Suffix 
      , @EmailPromotion 
      , @AdditionalContactInfo
      ,@Demographics
      ,@rowguid 
      ,@ModifiedDate
	);
