CREATE VIEW vw_DimProducts AS 
SELECT p.[ProductID]
      ,p.[Name] Product
      ,ps.[Name] Subcategory
      ,pc.[Name] Category
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps ON ps.ProductSubcategoryID = p.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc ON pc.ProductCategoryID = ps.ProductCategoryID