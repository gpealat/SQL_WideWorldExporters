-- Q6: Give me all the orders that have not been invoiced yet
USE WideWorldImporters

-- Relational Algebra
-- T1 = σ_Sales.Invoices()
-- T2 = π_T1( OrderID )

-- T3 = σ_Sales.Orders( OrderID NOT IN T2 )
-- T4 = π_T3( OrderID )

SELECT
	orders.OrderID
FROM
	Sales.Orders AS orders
WHERE
	orders.OrderID NOT IN (
						SELECT DISTINCT OrderID
						FROM Sales.Invoices
						) 
