--1.--Return the FirstName, and LastName of the Customers 
    --who have not made a Purchase in the last 6 months of 2016 (July-December).
-- Common table from 3 files: 
WITH t AS (
SELECT pu.*, 
       pr.ProductName, pr.RecommendedPrice, pr.Category, 
	   cu.FirstName, cu.LastName
FROM dbo.purchase AS pu 
LEFT JOIN dbo.product AS pr 
ON pu.ProductID = pr.ProductID
LEFT JOIN dbo.customer AS cu
ON pu.CustomerID = cu.CustomerID
)
--- 1st Question. 
SELECT FirstName, LastName FROM customer 
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM t
WHERE PurchaseDate between '2016-07-01' and '2016-12-31')