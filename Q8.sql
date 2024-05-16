-- Q8: Generate a report of the revenues for the years 2013 and 2014

USE WideWorldImporters

-- Relational Algebra
-- Getting the invoices from 2013 and 2014
-- T1 = σ_Sales.Invoices( InvoiceDate year IN (2013,2014))
-- T2 = π_T1( InvoiceID, YEAR(InvoiceDate) )
-- T3 = rho_T3( YEAR(InvoiceDate) / InvoiceYear )

-- Getting the invoices from 2013 and 2014
-- T4 = T3 JOIN Sales.InvoiceLines(InvoiceID)
-- T5 = σ_T4( )
-- T5 = π_T4( InvoiceYear, Quantity, UnitPrice)

SELECT
	T3.InvoiceYear, SUM(lines.Quantity * lines.UnitPrice) AS YearlyRevenue
FROM
	Sales.InvoiceLines as lines,
	(
		SELECT
			InvoiceID, YEAR(InvoiceDate) AS InvoiceYear
		FROM Sales.Invoices
		WHERE 
			YEAR(InvoiceDate) IN (2013,2014)
	) AS T3
WHERE
	T3.InvoiceID = lines.InvoiceID
GROUP BY
	T3.InvoiceYear
