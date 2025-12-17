# First-time riders (first ride per user)
SELECT * FROM (SELECT r.*, ROW_NUMBER() OVER(PARTITION BY user_id
ORDER BY ride_date) AS rn FROM rides r) t
WHERE rn = 1;

# Active users (≥3 completed rides in last 30 days)
SELECT u.user_id, u.user_name, COUNT(*) AS completed_rides
FROM users u JOIN rides r ON u.user_id = r.user_id
WHERE r.status = 'completed'
AND r.ride_date >= 
(SELECT DATE_SUB(MAX(ride_date), INTERVAL 30 DAY)
FROM rides)
GROUP BY u.user_id, u.user_name
HAVING COUNT(*) >= 3;

# High-value users (top 10% by spending)
SELECT user_id, user_name, total_spending, pr FROM 
(SELECT u.user_id, u.user_name, SUM(r.fare) AS total_spending,
PERCENT_RANK() OVER (ORDER BY SUM(r.fare)) AS pr
FROM users u JOIN rides r ON u.user_id = r.user_id
WHERE r.status = 'completed'
GROUP BY u.user_id, u.user_name) t
WHERE pr >= 0.80;

# Driver distance variability
SELECT d.driver_id, d.driver_name, 
AVG(r.distance_km) AS avg_distance,
STDDEV(r.distance_km) AS stdev_distance
FROM drivers d JOIN rides r ON d.driver_id = r.driver_id
GROUP BY d.driver_id, d.driver_name
HAVING STDDEV(r.distance_km) > 0;

# User retention cohort
SELECT signup_month, COUNT(DISTINCT user_id) AS retained_users FROM
(SELECT u.user_id, DATE_FORMAT(u.signup_date, '%Y-%m') AS signup_month
FROM users u JOIN rides r ON u.user_id = r.user_id
WHERE r.ride_date >= 
(SELECT DATE_SUB(MAX(ride_date), INTERVAL 30 DAY) FROM rides)) t
GROUP BY signup_month;

# Driver cancellation impact (lost revenue)
SELECT driver_id, AVG(CASE WHEN status = 'completed' THEN fare END)
* SUM(CASE WHEN status LIKE 'cancelled%' THEN 1 ELSE 0 END)
AS lost_revenue
FROM rides GROUP BY driver_id;

# Longest ride per driver
SELECT * FROM 
(SELECT r.*, RANK() OVER (PARTITION BY driver_id 
ORDER BY distance_km DESC) AS rnk FROM Rides r) t
WHERE rnk = 1;

# Users who used only one driver
SELECT u.user_id, u.user_name FROM users u 
JOIN rides r ON u.user_id = r.user_id 
GROUP BY u.user_id
HAVING COUNT(DISTINCT driver_id) = 1;

# Frequent cancellers (>40%)
SELECT user_id, SUM(status LIKE 'cancelled%') / COUNT(*) AS cancel_rate
FROM rides GROUP BY user_id
HAVING cancel_rate > 0.40;

# Cancellation reason comparison
SELECT driver_id, 
SUM(status = 'cancelled_by_user') AS user_cancels,
SUM(status = 'cancelled_by_driver') AS driver_cancels
FROM rides
GROUP BY driver_id;