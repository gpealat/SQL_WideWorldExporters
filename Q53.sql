-- Q53: By customer name, determine and present the number of invoices as NumberOfInvoices, 
-- the total quantity of items purchased and the total extended price.

USE WideWorldImporters

-- Relational Algebra
-- Getting the CustomerID and the InvoiceID for each invoice
-- T1 = σ_Sales.Invoices()
-- T2 = π_T1( InvoiceID, CustomerID )

-- Getting the CustomerName
-- T3 = T2 JOIN Sales.Customer (CustomerID)
-- T4 = π_T2(CustomerName, InvoiceID)

-- Getting the Quantity and Extended Price
-- T5 = T4 JOIN Sales.InvoiceLines(InvoiceID)
-- T6 = π_T5(InvoiceID, Quantity, ExtendedPrice)

SELECT
	T4.CustomerName,
	COUNT(T4.InvoiceID) AS NumberOfInvoices, 
	SUM(lines.Quantity) AS TotalQuantity, 
	SUM(lines.ExtendedPrice) AS TotalExtendedPrice
FROM
	Sales.InvoiceLines as lines,
	(
	SELECT
		cust.CustomerName, T2.InvoiceID
	FROM
		Sales.Customers AS cust,
		(
			SELECT
				InvoiceID, CustomerID
			FROM
				Sales.Invoices
		) AS T2
	WHERE
		T2.CustomerID = cust.CustomerID
	) AS T4
WHERE
	T4.InvoiceID = lines.InvoiceID
GROUP BY
	T4.CustomerName
ORDER BY
	TotalExtendedPrice DESC
