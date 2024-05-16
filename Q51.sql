-- Q51: Using the customers, invoices and invoice lines table, produce a report of the customer name, 
-- invoice date, quantity of items as TotalQuantity and extended price as TotalPrice for each

USE WideWorldImporters

-- Relational Algebra
-- Getting the customerID and InvoiceID for each invoice
-- T1 = σ_Sales.Invoices()
-- T2 = π_T1( CustomerID, InvoiceID )

-- Getting the CustomerName for each customer
-- T3 = T2 JOIN Sales.Customer (CustomerID)
-- T4 = σ_T2( )
-- T5 = π_T4( T2.InvoiceID, CustomerName, InvoiceDate)

-- Getting the Quantity for each item in the invoice
-- T6 = T5 JOIN Sales.InvoiceLines (InvoiceID)
-- T7 = σ_T6( )
-- T8 = π_T4( T5.InvoiceID, T5.CustomerName, T5.InvoiceDate, T7.Quantity, T7.ExtendedPrice)


SELECT T5.InvoiceID, T5.InvoiceDate, T5.CustomerName, SUM(lines.Quantity) AS TotalQuantity, SUM(lines.ExtendedPrice) AS TotalPrice
FROM
	Sales.InvoiceLines as lines,
	(
	SELECT T2.InvoiceID, cust.CustomerName, T2.InvoiceDate
	FROM Sales.Customers as cust,
		(
			SELECT CustomerID, InvoiceID, InvoiceDate
			FROM
				Sales.Invoices
		) AS T2
	WHERE
		cust.CustomerID = T2.CustomerID
	) AS T5
WHERE
	T5.InvoiceID = lines.InvoiceID
GROUP BY
	T5.InvoiceID, T5.InvoiceDate, T5.CustomerName
