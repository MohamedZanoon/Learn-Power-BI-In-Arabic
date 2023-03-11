ALTER VIEW vw_SalesOrderDetail AS 
SELECT TOP 100 PERCENT 
       od.[SalesOrderID]
      ,[SalesOrderDetailID]
      ,[CarrierTrackingNumber]
      ,[OrderQty]
      ,[ProductID]
      ,[SpecialOfferID]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]

	  ,o.OrderDate
  FROM [AdventureWorks].[Sales].[SalesOrderDetail] od
  LEFT JOIN Sales.SalesOrderHeader o ON o.SalesOrderID = od.SalesOrderID
  ORDER BY o.OrderDate DESC