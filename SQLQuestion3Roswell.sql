WITH t AS (
SELECT pu.*, 
       pr.ProductName, pr.RecommendedPrice, pr.Category, 
	   cu.FirstName, cu.LastName
FROM dbo.purchase AS pu 
LEFT JOIN dbo.product AS pr 
ON pu.ProductID = pr.ProductID
LEFT JOIN dbo.customer AS cu
ON pu.CustomerID = cu.CustomerID
),
q3 AS (
SELECT Category, CustomerID, FirstName, LastName, sum(PurchasePrice) AS TotalSales,
		RANK() OVER (PARTITION BY Category ORDER BY sum(PurchasePrice) desc) AS Ranking FROM t
GROUP BY Category, CustomerID, FirstName, LastName
)
SELECT Category, CustomerID, FirstName, LastName FROM q3
WHERE Ranking <3; 


