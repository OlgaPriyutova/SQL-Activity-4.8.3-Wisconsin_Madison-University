WITH t AS (
SELECT pu.*, 
       pr.ProductName, pr.RecommendedPrice, pr.Category, 
	   cu.FirstName, cu.LastName, cu.City, cu.State, cu.Zip 
FROM dbo.purchase AS pu 
LEFT JOIN dbo.product AS pr 
ON pu.ProductID = pr.ProductID
LEFT JOIN dbo.customer AS cu
ON pu.CustomerID = cu.CustomerID
),

--2.	Return the ProductCategory and the average PurchasePrice for all customers 
--      who have purchased three or more unique products.


cat_pr AS (SELECT Category, PurchasePrice FROM t 
WHERE CUstomerID in (
SELECT CustomerID FROM t
GROUP BY CustomerID
HAVING count(DISTINCT ProductID) >=3)
)

SELECT Category, avg(PurchasePrice) AS AvPricePerCategory 
FROM cat_pr
GROUP BY Category
;

