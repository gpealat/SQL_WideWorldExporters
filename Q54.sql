--Q52: Write a SQL query to find the top 5 customers with the highest total profit amount in the year 2014,
-- along with their respective maximum profit over 1 order.
USE WideWorldImporters

-- Relational Algebra
-- Getting the top 5 clients for 2014
-- T1 = σ_Sales.Invoices( InvoiceDate year = 2014)
-- T2 = π_T1( InvoiceID, CustomerID )

-- Getting the customer names in T2
-- T3 = T2 JOIN σ_Sales.Customers (CustomerID)
-- T4 = σ_T3()
-- T5 = π_T4( InvoiceID, CustomerName)

-- Getting the LineProfit for each items
-- T6 = T5 JOIN Sales.InvoiceLines(InvoiceID)
-- T7 = σ_T6()
-- T8 = T7 GROUP BY (CustomerName)
-- T9 = π_T8(CustomerName, MAX(LineProfit), SUM(LineProfit)
-- T10 = rho_T9( SUM(LineProfit) / YearProfit, MAX(lines.LineProfit) / MaxProfit )
-- T11 = T10_ORDER BY(YearProfit)
-- T12 = T11_TOP 5


SELECT TOP 5
	CustomerName, MAX(lines.LineProfit) AS MaxProfit, SUM(lines.LineProfit) AS YearProfit
FROM
	Sales.InvoiceLines AS lines,
	(
		SELECT
			T2.InvoiceID, cust.CustomerName
		FROM
			Sales.Customers AS cust,
			(
				SELECT
					InvoiceID, CustomerID
				FROM
					Sales.Invoices
				WHERE 
					YEAR(InvoiceDate) = 2014
			) AS T2
		WHERE
			cust.CustomerID = T2.CustomerID
	) AS T5
WHERE
	lines.InvoiceID = T5.InvoiceID
GROUP BY
	T5.CustomerName
ORDER BY
	YearProfit DESC
