-- Q7: Calculate the profit of the compnay for the year 2014

USE WideWorldImporters

-- Relational Algebra
-- Getting the invoices from 2014
-- T1 = σ_Sales.Invoices( InvoiceDate year = 2014)
-- T2 = π_T1( InvoiceID )

-- Getting the InvoiceLines for each invoice
-- T3 = T2 JOIN Sales.InvoiceLines (InvoiceID)
-- T4 = π_T3( LineProfit )


SELECT SUM(LineProfit) AS YearProfit
FROM 
	Sales.InvoiceLines as lines,
	(
		SELECT InvoiceID
		FROM
			Sales.Invoices
		WHERE
			YEAR(InvoiceDate) = 2014
	) AS T2
WHERE
	T2.InvoiceID = lines.InvoiceID

-- If we also want the profit by month
SELECT T2.month AS [month], SUM(LineProfit)AS MonthlyProfit
FROM 
	Sales.InvoiceLines as lines,
	(
		SELECT InvoiceID, MONTH(InvoiceDate) AS [month]
		FROM
			Sales.Invoices
		WHERE
			YEAR(InvoiceDate) = 2014
	) AS T2
WHERE
	T2.InvoiceID = lines.InvoiceID
GROUP BY [month]
ORDER BY [month] ASC
