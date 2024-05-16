-- Q50: Find the person (people) name, quantity of items ordered from people, orders and order lines.
USE WideWorldImporters

-- Relational Algebra
-- Get all customers who are not companies
-- T1 = σ_Sales.Customer(BuyingGroupID IS NULL)
-- T2 = π_T1( CustomerID )

-- Get all OrderID for the customers
-- T3 = T2 JOIN Sales.Orders( CustomerID = T2.CustomerID )
-- T4 = σ_T3()
-- T5 = π_T4( OrderID )

-- Get all StockItemsID for orderID
-- T6 = T5 JOIN Sales.OrderLines( OrderID = T4.OrderID )
-- T7 = σ_T6
-- T8 = π_T7( Quantity )

SELECT
	SUM(orderline.Quantity) AS TotalQuantityBought, T4.CustomerName
FROM
	Sales.OrderLines as orderline,
	(
	SELECT
		[order].OrderID, T2.CustomerID, T2.CustomerName
	FROM
		Sales.Orders as [order],
		(
		SELECT CustomerID, CustomerName
		FROM Sales.Customers 
		WHERE BuyingGroupID IS NULL
		) AS T2
	WHERE
		[order].CustomerID = T2.CustomerID
	) AS T4
WHERE
	orderline.OrderID = T4.OrderID
GROUP BY
	T4.CustomerName
