--Q56: write a SQL query to find all customers who placed at least one order in the year 2013.
USE WideWorldImporters

-- Relational Algebra
-- Getting CustomerID that have at least 1 order in 2013
-- T1 = σ_Sales.Orders( OrderDate year = 2013)
-- T2 = π_T1( OrderID)

-- Getting the Customer names
-- T3 = σ_Sales.Customers( CustomerID IN T2)
-- T4 = π_T3( CustomerName)


SELECT
	cust.CustomerID, cust.CustomerName
FROM
	Sales.Customers AS cust
WHERE
	EXISTS
	(
		SELECT
			OrderID
		FROM
			Sales.Orders
		WHERE
			YEAR(OrderDate) = 2013
			AND cust.CustomerID = CustomerID
	)
