SELECT *
FROM [AdventureWorks].[Sales].[SalesOrderHeader]
WHERE SalesOrderID = 43661 

SELECT *
FROM [AdventureWorks].[Sales].[SalesOrderDetail]
WHERE SalesOrderID = 43661 

SELECT *
FROM [Production].[Product]
WHERE ProductID = 745 
 
SELECT *
FROM [Production].[ProductSubcategory]
WHERE ProductSubcategoryID = 12

SELECT *
FROM [Production].[ProductCategory]
WHERE ProductCategoryID = 2

SELECT *
FROM [Sales].[SalesTerritory]
WHERE TerritoryID  = 6


--------------------------------------

SELECT SUM(Subtotal)
FROM [AdventureWorks].[Sales].[SalesOrderHeader] 

SELECT SUM(linetotal)
FROM [AdventureWorks].[Sales].[SalesOrderDetail] 