CREATE VIEW vw_DimStatuses AS
SELECT 1 StatusID, 'In process'  [Status] UNION ALL
SELECT 2 StatusID, 'Approved'	 [Status] UNION ALL
SELECT 3 StatusID, 'Backordered' [Status] UNION ALL
SELECT 4 StatusID, 'Rejected'	 [Status] UNION ALL
SELECT 5 StatusID, 'Shipped'	 [Status] UNION ALL
SELECT 6 StatusID, 'Cancelled'	 [Status]