-- Q5: Give me the list of the items that are not USB and priced greater or equal to any USB items

USE WideWorldImporters


-- Relational Algebra
-- T1 = σ_Warehouse.StockItems( UPPER(StockItemName) NOT LIKE 'USB %' )
-- T2 = π_T1( StockItemName,UnitPrice )

-- T3 = σ_Warehouse.StockItems( UPPER(StockItemName) LIKE 'USB %' )
-- T4 = π_T1( ρ( MIN(UnitPrice)/target_price)   )

-- T5 = σ_T2xT4( reference.UnitPrice >= T4.target_price


SELECT
	reference.StockItemName, reference.UnitPrice
FROM 
	(
		SELECT StockItemName,UnitPrice
		FROM Warehouse.StockItems
		WHERE UPPER(StockItemName) NOT LIKE 'USB %'		-- Even if we are CI, we can make sure it works
	) AS reference,
	(
		SELECT MIN(UnitPrice) AS target_price
		FROM Warehouse.StockItems
		WHERE UPPER(StockItemName) LIKE 'USB %'		-- Even if we are CI, we can make sure it works
	) AS [target]
WHERE
	reference.UnitPrice >= [target].target_price
ORDER BY 
	reference.UnitPrice DESC
