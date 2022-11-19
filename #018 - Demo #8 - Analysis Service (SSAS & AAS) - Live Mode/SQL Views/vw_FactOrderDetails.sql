ALTER VIEW vw_FactOrderDetails AS
SELECT od.SalesOrderID AS OrderID
      ,od.SalesOrderDetailID AS OrderDetailID 
      ,od.OrderQty
      ,od.ProductID
      ,od.UnitPrice 
      ,od.LineTotal

	  ,FORMAT(o.OrderDate, 'yyyyMMdd') OrderDateKey
      ,FORMAT(o.DueDate  , 'yyyyMMdd') DueDateKey
      ,FORMAT(o.ShipDate , 'yyyyMMdd') ShipDateKey

      ,o.[Status] StatusID
      ,o.OnlineOrderFlag
      ,o.CustomerID
      ,o.SalesPersonID
      ,o.TerritoryID 
      ,o.ShipMethodID 
      
      ,(CAST(od.[LineTotal] AS DECIMAL(18,5)) / o.SubTotal ) * o.TaxAmt AS TaxAmt
      ,(CAST(od.[LineTotal] AS DECIMAL(18,5)) / o.SubTotal ) * o.Freight AS Freight
      ,(CAST(od.[LineTotal] AS DECIMAL(18,5)) / o.SubTotal ) * o.TotalDue AS TotalDue 
FROM Sales.SalesOrderDetail od
LEFT JOIN Sales.SalesOrderHeader o ON o.SalesOrderID = od.SalesOrderID