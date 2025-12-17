# Total number of rides per user
SELECT user_id, COUNT(*) AS total_rides
FROM rides
GROUP BY user_id;

# Total revenue per driver (completed rides only)
SELECT driver_id, SUM(fare) AS revenue
FROM rides
WHERE status = 'completed'
GROUP BY driver_id
ORDER BY revenue DESC;

# Average ride distance per user
SELECT user_id, ROUND(AVG(distance_km), 2) AS avg_distance
FROM rides
GROUP BY user_id;

# Total completed and cancelled rides per day
SELECT ride_date, 
SUM(status = 'completed') AS completed_rides,
SUM(status LIKE 'cancelled%') AS cancelled_rides
FROM rides
GROUP BY ride_date
ORDER BY ride_date;

# Total revenue generated per day
SELECT ride_date, SUM(fare) AS revenue
FROM rides
WHERE status='completed'
GROUP BY ride_date;

# Cancellation rate per driver
SELECT driver_id, SUM(status LIKE 'cancelled%') AS cancelled_rides,
COUNT(*) AS total_rides,
SUM(status LIKE 'cancelled%') / COUNT(*) AS cancelled_rate
FROM rides
GROUP BY driver_id;

# Top 3 users based on total money spent 
SELECT user_id, SUM(fare) AS total_spent
FROM rides
WHERE status='completed'
GROUP BY user_id
ORDER BY total_spent DESC LIMIT 3; 

# Count rides by users who signed up in each month
SELECT DATE_FORMAT(u.signup_date, '%Y-%m') AS signup_month,
COUNT(r.ride_id) AS total_rides
FROM users u
JOIN rides r ON u.user_id = r.user_id
GROUP BY DATE_FORMAT(u.signup_date, '%Y-%m')
ORDER BY signup_month;

# Monthly revenue for Pathao
SELECT DATE_FORMAT(ride_date, '%Y-%m') AS month,
SUM(fare) AS total_revenue
FROM rides
WHERE status = 'completed'
GROUP BY DATE_FORMAT(ride_date, '%Y-%m')
ORDER BY month;