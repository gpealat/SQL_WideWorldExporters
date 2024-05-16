-- Q49: Select the customer name and website URL for customers that have placed orders before January 16, 2013.
USE WideWorldImporters

-- Relational Algebra
-- T1 = σ_Sales.Orders( OrderDate < '2013-01-16'))
-- T2 = π_T1( CustomerID )

-- T3 = T2 JOIN Customers (ON CustomerID)
-- T4 = π_T3( CustomerName, WebsiteURL)

SELECT DISTINCT		-- A same customer might have made multiple orders this day
	cust.CustomerName, cust.WebsiteURL
FROM
	(
		SELECT CustomerID
		FROM Sales.Orders
		WHERE OrderDate < '2013-01-16'
	) AS custid,
	Sales.Customers as cust
WHERE 
	cust.CustomerID = custid.CustomerID
