CREATE VIEW vw_DimTerritories AS
SELECT TerritoryID
      ,[Name] Territory
      ,CountryRegionCode
      ,[Group]
  FROM Sales.SalesTerritory