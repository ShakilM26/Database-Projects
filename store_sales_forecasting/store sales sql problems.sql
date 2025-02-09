-- Find the total sales amount for each category.
SELECT p.category, SUM(s.sales) AS TotalSales 
FROM product p 
JOIN sales s ON p.ProductID = s.ProductID 
GROUP BY p.category;

-- List the top 5 cities with the highest number of orders.
SELECT c.city, COUNT(o.OrderID) AS Order_Count FROM customer c 
JOIN orders o ON c.CustomerID = o.CustomerID 
GROUP BY c.city ORDER BY Order_Count DESC LIMIT 5;

-- Find the average profit percentage for each sub-category.
SELECT p.SubCategory, CONCAT(ROUND(AVG((s.profit / s.sales) * 100), 2), '%') AS Average_Profit_Percentage
FROM product p 
JOIN sales s ON s.ProductID = p.ProductID
GROUP BY p.SubCategory;

-- Retrieve the top 3 products that generated the highest profit.
SELECT p.ProductName, ROUND(SUM(s.profit), 2) AS Highest_Profit
FROM product p 
JOIN sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName ORDER BY Highest_Profit DESC LIMIT 3;

-- Find the month with the highest total sales.
SELECT MONTH(OrderDate) AS Top_Month, ROUND(SUM(s.sales), 2) AS Highest_TotalSales
FROM sales s
JOIN orders o ON o.OrderID = s.OrderID
GROUP BY Top_Month ORDER BY Highest_TotalSales DESC LIMIT 1;

-- Count the number of unique customers who have placed an order.
SELECT COUNT(DISTINCT CustomerID) AS Unique_Customers FROM customer;

-- Identify the customer who made the highest number of purchases.
SELECT c.CustomerID, c.CustomerName, COUNT(*) AS Highest_TotalPurchase
FROM customer c
JOIN orders o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName ORDER BY Highest_TotalPurchase DESC LIMIT 1;

-- Find the customer segment that contributes the most to total sales.
SELECT Segment, ROUND(SUM(sales), 2)
FROM stores_sales_forecasting GROUP BY Segment;


-- Identify the shipping mode that results in the highest average profit per order.
SELECT o.ShipMode, AVG(s.Profit) AS Average_Profit 
FROM sales s
JOIN orders o ON o.OrderID = s.OrderID
GROUP BY ShipMode 
ORDER BY Average_Profit DESC 
LIMIT 1;

-- 1. Find the customer with the highest total sales and their total order count
SELECT c.CustomerID, c.CustomerName, COUNT(s.OrderID) AS TotalOrder, SUM(s.Sales) AS TotalSales
FROM sales s
JOIN customer c ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalSales DESC 
LIMIT 1;

-- Identify the top 3 most profitable product categories
SELECT ProductName, Profit FROM stores_sales_forecasting
ORDER BY Profit DESC
LIMIT 3;

-- 4. Identify the top 5 cities where discounts lead to the highest profit loss
SELECT c.City, SUM(s.Profit) AS Total_ProfitLoss, SUM(s.Discount) AS TotalDiscount
FROM customer c
JOIN sales s ON s.CustomerID = c.CustomerID
WHERE s.Profit < 0
GROUP BY c.City
ORDER BY Total_ProfitLoss ASC
LIMIT 5;

-- 5. Find the top 3 most frequently purchased products in each region
WITH ProductCounts AS (
SELECT Region, ProductName, COUNT(*) AS Total_Purchased,
	   ROW_NUMBER() OVER (PARTITION BY Region ORDER BY COUNT(*) DESC) AS rn
FROM stores_sales_forecasting
GROUP BY Region, ProductName)

SELECT Region, ProductName, Total_Purchased
FROM ProductCounts
WHERE rn <= 3
ORDER BY Region, Total_Purchased DESC;

-- 6. Find customers who have placed orders in multiple regions
SELECT s.CustomerID, c.CustomerName, COUNT(DISTINCT c.Region) AS RegionCount
FROM sales s
JOIN customer c ON s.CustomerID = c.CustomerID
GROUP BY s.CustomerID, c.CustomerName
HAVING RegionCount > 1;

-- 8. Identify products that generate high sales but low profit margins
SELECT p.ProductName, SUM(s.Sales) AS High_Sales, SUM(s.Profit) AS Profit,
(SUM(s.Profit) / SUM(s.Sales)) * 100 AS ProfitMargin
FROM product p
JOIN sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName 
HAVING ProfitMargin < 10
ORDER BY High_Sales DESC
LIMIT 10;


-- 9. Find customers who have placed orders every month for the last 6 months
WITH CustomersOrders AS (
	SELECT CustomerID, DATE_FORMAT(OrderDate, '%Y-%m') AS OrderMonth
    FROM stores_sales_forecasting
	WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY CustomerID, OrderMonth)
SELECT CustomerID
FROM CustomersOrders
GROUP BY CustomerID
HAVING COUNT(DISTINCT OrderMonth) = 6;

-- 10. Find the most returned product by checking negative profit orders
SELECT p.ProductName, SUM(s.Profit) AS Profit, COUNT(s.OrderID) AS ReturnCount
FROM sales s
JOIN product p ON s.ProductID = p.ProductID
WHERE s.Profit < 0
GROUP BY p.ProductName
ORDER BY ReturnCount DESC
LIMIT 5;







