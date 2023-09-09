
#1 What is the total sales revenue for Adidas products in the dataset?
SELECT Product, SUM(`Total Sales`) AS Total_Sales
FROM adidas_us_sales
GROUP BY Product
ORDER BY Total_Sales  DESC;

#2 How many units of Adidas products were sold in each state?
SELECT State, SUM(`Units Sold`) From adidas_us_sales GROUP BY State;

#3 Which retailer had the highest total sales, and which had the lowest?
select Retailer, SUM(`Total Sales`) AS Total_Sales from adidas_us_sales GROUP BY Retailer ORDER BY Total_Sales ASC;

#4 What is the average operating margin for Adidas products in each region?
SELECT Region, ROUND(AVG(`Operating Margin`), 2) AS Avg_OperatingMargin 
FROM adidas_us_sales 
GROUP BY Region 
ORDER BY Avg_OperatingMargin DESC;

#5. Can you identify the top 5 best-selling Adidas products based on the total number of units sold?
SELECT Product, SUM(`Units Sold`) AS Total_unit_sold FROM adidas_us_sales GROUP BY Product ORDER BY Total_unit_sold DESC Limit 5;

#6. Which sales method (e.g., online, in-store) generated the highest operating profit for Adidas products?
SELECT `Sales Method`, SUM(`Operating Profit`) AS Highest_Profit  
FROM adidas_us_sales GROUP BY `Sales Method` ORDER BY Highest_Profit DESC LIMIT 1;

#7. Calculate the total sales and profit for Adidas products in each city and rank the cities accordingly.
SELECT City, SUM(`Total Sales`) AS total_sales FROM adidas_us_sales GROUP BY City ORDER BY total_sales DESC;

#8. Calculate the average price per unit for Adidas products in each state and identify states with the highest and lowest average prices.
SELECT State, avg_price FROM  
(SELECT State, AVG(`Price per Unit`) AS avg_price FROM adidas_us_sales 
GROUP BY State ORDER BY avg_price DESC LIMIT 1) AS Highest_price 
UNION 
SELECT State, avg_price FROM (SELECT State, AVG(`Price per Unit`) AS avg_price FROM adidas_us_sales
GROUP BY State ORDER BY avg_price ASC LIMIT 1) AS Lowest_price;

#9. Can you find any correlations between the price per unit and operating profit for Adidas products? 
# Is there a relationship between the two variables?
  

#10. Is there a difference in the average price per unit between online and in-store sales methods?
SELECT `Sales Method`, AVG(`Price per Unit`) AS Average_price 
FROM adidas_us_sales WHERE `Sales Method` IN ('Online', 'In-store') 
GROUP BY `Sales Method`;

#11. alter table adidas_us_sales modify column `Invoice Date` DATE;
-- describe adidas_us_sales;

#12. Calculate Sales and Profit over the year.
SELECT YEAR(`Invoice Date`) AS YEARS, 
ROUND(AVG(`Total Sales`), 2) AS Total_sales, 
ROUND(AVG(`Operating Profit`), 2) AS operating_profit 
FROM adidas_us_sales 
GROUP BY YEARS ORDER BY YEARS DESC;

