CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT,
    Supplier VARCHAR(100)
);
INSERT INTO Product VALUES
(1, 'Laptop', 'Electronics', 70000, 50, 'TechMart'),
(2, 'Office Chair', 'Furniture', 5000, 100, 'HomeComfort'),
(3, 'Smartwatch', 'Electronics', 15000, 200, 'GadgetHub'),
(4, 'Desk Lamp', 'Lighting', 1200, 300, 'BrightLife'),
(5, 'Wireless Mouse', 'Electronics', 1500, 250, 'GadgetHub');

--1. CRUD OPERATIONS

--  1.Add a new product: Gaming Keyboard
INSERT INTO Product (ProductID, ProductName, Category, Price, StockQuantity, Supplier)
VALUES (6, 'Gaming Keyboard', 'Electronics', 3500, 150, 'TechMart');

--  2.Update product price: Increase Electronics prices by 10%
UPDATE Product
SET Price = Price * 1.10
WHERE Category = 'Electronics';

--  3.Delete a product: Remove ProductID = 4 (Desk Lamp)
DELETE FROM Product
WHERE ProductID = 4;

--  4.Read all products: Sort by Price in descending order
SELECT * FROM Product
ORDER BY Price DESC;


--2. SORTING AND FILTERING

--  5.Sort products by StockQuantity ascending
SELECT * FROM Product
ORDER BY StockQuantity ASC;

--  6.Filter by Category: Electronics
SELECT * FROM Product
WHERE Category = 'Electronics';

--  7.Filter with AND: Electronics AND Price > 5000
SELECT * FROM Product
WHERE Category = 'Electronics' AND Price > 5000;

--  8.Filter with OR: Electronics OR Price < 2000
SELECT * FROM Product
WHERE Category = 'Electronics' OR Price < 2000;

--3. AGGREGATION AND GROUPING

--  9.Total stock value = SUM(Price * StockQuantity)
SELECT 
    ProductID,
    ProductName,
    Price,
    StockQuantity,
    (Price * StockQuantity) AS TotalStockValue
FROM Product;

--  10.Average price per Category
SELECT Category, AVG(Price) AS AvgPrice
FROM Product
GROUP BY Category;

--  11.Count of products by Supplier: GadgetHub
SELECT COUNT(*) AS TotalProducts
FROM Product
WHERE Supplier = 'GadgetHub';

--4. CONDITIONAL & PATTERN MATCHING

--  12.Find ProductName with keyword 'Wireless'
SELECT * FROM Product
WHERE ProductName LIKE '%Wireless%';

--  13.Products from suppliers: TechMart or GadgetHub
SELECT * FROM Product
WHERE Supplier IN ('TechMart', 'GadgetHub');

--  14.Filter using BETWEEN: Price between 1000 and 20000
SELECT * FROM Product
WHERE Price BETWEEN 1000 AND 20000;

--5. ADVANCED QUERIES

--  15.Products with StockQuantity > average stock
SELECT * FROM Product
WHERE StockQuantity > (SELECT AVG(StockQuantity) FROM Product);

--  16.Top 3 most expensive products
SELECT TOP 3 * FROM Product
ORDER BY Price DESC;

--  17.Find duplicate supplier names
SELECT Supplier
FROM Product
GROUP BY Supplier
HAVING COUNT(*) > 1;

--  18.Product summary: Category-wise count and stock value
SELECT 
    Category,
    COUNT(*) AS NumberOfProducts,
    SUM(Price * StockQuantity) AS TotalStockValue
FROM Product
GROUP BY Category;

--6. JOIN & SUBQUERIES

--  19.Supplier with most products
SELECT TOP 1 Supplier, COUNT(*) AS ProductCount
FROM Product
GROUP BY Supplier
ORDER BY ProductCount DESC;

--  20.Most expensive product per Category
SELECT *
FROM Product P
WHERE Price = (
    SELECT MAX(Price)
    FROM Product
    WHERE Category = P.Category
);
