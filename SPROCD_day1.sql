/**************************************************************
author: Kenneth O. Ejiofor
Date: 27.10.2021

****************************************************************/

ALTER PROCEDURE usp_Employee_maxwage
AS
select P.FirstName, P.LastName, HM.RateChangeDate, HM.Rate 
from [HumanResources].[EmployeePayHistory] AS HM
INNER JOIN [Person].[Person] AS P
ON HM.BusinessEntityID = P.BusinessEntityID
where Rate = (select MAX(Rate) from [HumanResources].[EmployeePayHistory]);

exec usp_Employee_maxwage;


select P.FirstName, P.LastName, HM.RateChangeDate, HM.Rate 
from [HumanResources].[EmployeePayHistory] AS HM
INNER JOIN [Person].[Person] AS P
ON HM.BusinessEntityID = P.BusinessEntityID
where Rate = (select MIN(Rate) from [HumanResources].[EmployeePayHistory]);

--SELECT TOP 2 PERCENT * FROM [Production].[Product];
--SELECT TOP 2 PERCENT * FROM [Production].[ProductSubcategory];
--SELECT TOP 2 PERCENT * FROM [Production].[ProductCategory];

	ALTER PROC usp_ProductbyCategory
	@category nvarchar(50),
	@price int
	AS

	SELECT P.Name as Product, CP.Name as Category, SP.Name as SubCategory, P.Color, P.ListPrice, P.SafetyStockLevel
	FROM [Production].[Product] AS P
	INNER JOIN [Production].[ProductSubcategory] AS SP
	ON P.ProductSubcategoryID = SP.ProductSubcategoryID
	INNER JOIN [Production].[ProductCategory] AS CP
	ON SP.ProductCategoryID = CP.ProductCategoryID
	WHERE CP.Name = @category and P.ListPrice >= @price
	order by P.Color ASC;

exec usp_ProductbyCategory @category = 'Clothing', @price = 50;

--DROP PROCEDURE usp_OnlyBike

	DECLARE @xyz int
	SET @xyz = 10
	SELECT 45 * @xyz