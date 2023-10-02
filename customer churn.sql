# How many unique customers are in the dataset?
SELECT COUNT(DISTINCT CustomerID) AS Total_Unique_Customers FROM customer_churn_dataset;

# What is the average age of the customers?
SELECT AVG(Age) FROM customer_churn_dataset;

# What is the gender distribution of the customers?
SELECT Gender, COUNT(*) AS Count FROM customer_churn_dataset GROUP BY Gender;

# What is the average tenure of customers?
SELECT AVG(Tenure) FROM customer_churn_dataset;

# How many customers are using each subscription type?
SELECT `Subscription Type`, COUNT(*) AS Count
FROM customer_churn_dataset
GROUP BY `Subscription Type`;

# What is the most common contract length among customers?
SELECT `Contract Length`, COUNT(*) AS Count 
FROM customer_churn_dataset 
GROUP BY `Contract Length` 
ORDER BY Count DESC LIMIT 1;

# What is the average total spend of customers?
SELECT AVG(`Total Spend`) AS Average_spend FROM customer_churn_dataset;

# How many customers have churned?
SELECT `Churn`, COUNT(*) FROM customer_churn_dataset WHERE `Churn` = 1;

# What is the churn rate for the dataset?
SELECT (SUM(`Churn`=1)/COUNT(*)) AS ChurnRate FROM customer_churn_dataset;

# How many customers have made support calls?
SELECT COUNT(*) AS Total_Customers_SupportCalls 
FROM customer_churn_dataset 
WHERE `Support Calls` > 0;

# What is the average number of support calls made by customers?
SELECT AVG(`Support Calls`) AS Avg_SupportCalls 
FROM customer_churn_dataset;

# What is the average payment delay among customers?
SELECT AVG(`Payment Delay`) AS Avg_payment 
FROM customer_churn_dataset;

# How many customers have a payment delay of more than 5 days?
SELECT COUNT(*) AS Total_Customers FROM customer_churn_dataset WHERE `Payment Delay` > 5;

