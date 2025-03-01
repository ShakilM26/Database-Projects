-- Question 1: Total Sales Revenue
SELECT SUM(Total_Price) AS Total_Revenue from orders;

-- Question 2: Which product has the highest total sales (based on the quantity sold)?
SELECT Product_Name, SUM(Quantity) AS Total_Quantity_Sold FROM ecommerce_sales_data 
GROUP BY Product_Name 
ORDER BY Total_Quantity_Sold DESC LIMIT 1; 

-- Question 3: Which customer has spent the most on orders?
SELECT CustomerID, SUM(Total_Price) AS Total_Spent FROM ecommerce_sales_data
GROUP BY CustomerID 
ORDER BY Total_Spent DESC LIMIT 1;

-- Question 4: What is the total sales revenue by region?
SELECT Region, SUM(Total_Price) AS Total_Revenue FROM ecommerce_sales_data 
GROUP BY Region 
ORDER BY Total_Revenue DESC;

-- Question 5: What is the average age of customers who have made a purchase?
SELECT AVG(Age) AS Average_Age FROM Customers
WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM Orders);

-- Question 6: How many units of each product were sold?
SELECT Product_Name, SUM(Quantity) AS Total_Quantity_Sold FROM ecommerce_sales_data 
GROUP BY Product_Name 
ORDER BY Total_Quantity_Sold DESC;

-- Question 7: What is the total sales revenue generated by each gender?
SELECT Gender, SUM(Total_Price) AS Total_Revenue
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Gender;

-- Question 8: How many orders are pending, shipped, and delivered?
SELECT Shipping_Status, COUNT(*) AS Order_Count
FROM Orders GROUP BY Shipping_Status;

-- Question 9: Highest Spending Customer
SELECT CustomerID, SUM(Total_Price) AS Total_Spent
FROM Orders GROUP BY CustomerID
ORDER BY Total_Spent DESC;


-- Question 10: What is the total revenue generated by each product category?
SELECT Category, SUM(Total_Price) AS Total_Revenue
FROM ecommerce_sales_data GROUP BY Category;

-- Question 11: What is the sales revenue for each month in the dataset?
SELECT MONTH(Order_Date) AS Month, YEAR(Order_Date) AS Year, SUM(Total_Price) AS Monthly_Revenue
FROM Orders
GROUP BY Year, Month
ORDER BY Year, Month;

-- Question 12: Total Revenue in each Region
SELECT Region, SUM(Total_Price) AS Total_Revenue
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Region
ORDER BY Total_Revenue DESC; 