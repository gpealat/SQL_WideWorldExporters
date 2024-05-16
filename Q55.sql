--Q55: Write a SQL query to find the top 3 product categories by total sales amount in the year 2013, 
-- along with their respective total sales amounts.
USE WideWorldImporters

-- Relational Algebra
-- Getting the invoices for 2013
-- T1 = σ_Sales.Invoices( InvoiceDate year = 2013)
-- T2 = π_T1( InvoiceID)

-- Getting the StockItemID
-- T3 = T2 JOIN Sales.InvoiceLines(InvoiceID)
-- T4 = σ_T3()
-- T5 = T4_GROUP BY(StockItemID)
-- T6 = π_T5(StockItemID, SUM(LineProfit))
-- T7 = rho_T6( SUM(LineProfit) / YearProfit )
-- T8 = T7_ORDER BY (YearProfit) DESC
-- T9 = π_T8( TOP 3 StockItemID, YearProfit)

-- Getting the StockItemName
-- T10 = T9 JOIN Warehouse.StockItems(StockItemID)
-- T11 = σ_T10
-- T12 = π_T11(StockItemName, T9.YearProfit)

SELECT
	items.StockItemName, T9.YearProfit
FROM
	Warehouse.StockItems as items,
	(
		SELECT TOP 3
			lines.StockItemID, SUM(lines.LineProfit) AS YearProfit
		FROM
			Sales.InvoiceLines AS lines,
			(
				SELECT
					InvoiceID
				FROM
					Sales.Invoices
				WHERE
					YEAR(InvoiceDate) = 2013
			) AS T2
		WHERE
			lines.InvoiceID = T2.InvoiceID
		GROUP BY
			lines.StockItemID
		ORDER BY
			YearProfit DESC
	) AS T9
WHERE
	items.StockItemID = T9.StockItemID
