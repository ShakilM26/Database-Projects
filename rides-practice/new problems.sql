# Write a query to find the total number of rides for each status
SELECT status, COUNT(*) AS number_of_rides 
FROM rides GROUP BY status;

# Date Filtering: List the names of all drivers who joined the company in 2024.
SELECT driver_name FROM drivers WHERE YEAR(join_date) = 2024;

# Find the total earnings (SUM(fare)) for each driver. Display the driver_name and total_earnings.
SELECT d.driver_name, SUM(r.fare) AS total_earnings 
FROM rides r JOIN drivers d ON d.driver_id = r.driver_id
GROUP BY d.driver_name
ORDER BY total_earnings DESC;

# High Frequency Users: Find the user_id and user_name of customers who have taken more than 10 rides.
SELECT u.user_id, u.user_name, SUM(r.ride_id) AS TOTAL_RIDE 
FROM users u JOIN rides r ON u.user_id = r.user_id
GROUP BY u.user_id, u.user_name
HAVING TOTAL_RIDE > 10
ORDER BY TOTAL_RIDE DESC;

# Find the names of users who have signed up but have never taken a ride (Use LEFT JOIN or NOT IN).
SELECT user_name AS Ghost_users FROM users 
WHERE user_id NOT IN (SELECT DISTINCT user_id FROM rides);

# Write a query to calculate the total revenue generated per day (Group by ride_date).
SELECT ride_date, SUM(fare) AS daily_revenue 
FROM rides
WHERE status = 'completed' 
GROUP BY ride_date ORDER BY ride_date DESC;

# Find the names of users who have signed up but have never taken a ride (Use LEFT JOIN or NOT IN).
SELECT u.user_name FROM users u
LEFT JOIN rides r ON u.user_id = r.user_id
WHERE r.ride_id IS NULL;

SELECT user_name FROM users
WHERE user_id NOT IN (SELECT DISTINCT user_id FROM rides);