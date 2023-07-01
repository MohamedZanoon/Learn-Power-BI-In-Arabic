ALTER VIEW vw_ActualsGoals AS 
WITH Actuals_CTE AS
(
	SELECT MONTH(OrderDate) [Month] 
		  ,SUM(SubTotal) Amount
	FROM Sales.SalesOrderHeader
	WHERE YEAR(OrderDate) = 2012
	GROUP BY MONTH(OrderDate)
),
Goals_CTE AS 
(
	SELECT 1 [Month], 500000 AmountGoal UNION ALL
	SELECT 2 [Month], 500000 AmountGoal UNION ALL
	SELECT 3 [Month], 500000 AmountGoal UNION ALL
	SELECT 4 [Month], 500000 AmountGoal UNION ALL
	SELECT 5 [Month], 500000 AmountGoal UNION ALL
	SELECT 6 [Month], 500000 AmountGoal UNION ALL
	SELECT 7 [Month], 700000 AmountGoal UNION ALL
	SELECT 8 [Month], 700000 AmountGoal UNION ALL
	SELECT 9 [Month], 700000 AmountGoal UNION ALL
	SELECT 10 [Month], 800000 AmountGoal UNION ALL
	SELECT 11 [Month], 800000 AmountGoal UNION ALL
	SELECT 12 [Month], 800000 AmountGoal
)

SELECT a.[Month]  
	  ,a.Amount
	  ,g.AmountGoal
	  ,CASE 
			WHEN a.Amount >=  g.AmountGoal THEN 1 
			WHEN a.Amount >= g.AmountGoal * 0.9 THEN 0
			ELSE -1
		END AmountIndicator
		
FROM Actuals_CTE a
LEFT JOIN Goals_CTE g ON g.[Month] = a.[Month]

