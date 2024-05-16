-- Q39: Select the product name and recommended retail price where the price is more than $40.
USE WideWorldImporters

-- Relational Algebra
-- T1 = σ_Warehouse.StockItems( UnitPrice >= 40 )
-- T2 = π_T1( StockItemName,UnitPrice )


SELECT StockItemName, RecommendedRetailPrice
FROM Warehouse.StockItems
WHERE UnitPrice >= 40
ORDER BY UnitPrice DESC
