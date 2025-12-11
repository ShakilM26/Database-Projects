SELECT user_id, COUNT(*) AS total_rides,
RANK() OVER (ORDER BY COUNT(*) DESC) AS ride_rank
FROM rides
GROUP BY user_id;

SELECT driver_id, SUM(fare) AS revenue,
RANK() OVER (ORDER BY SUM(fare) DESC) AS rank_drivers
FROM rides
WHERE status='completed'
GROUP BY driver_id;

SELECT DATE_FORMAT(ride_date, '%Y-%m-%d') AS ride_days,
COUNT(*) AS rides,
RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_days
FROM rides
WHERE status='completed'
GROUP BY DATE_FORMAT(ride_date, '%Y-%m-%d');

SELECT user_id, 
ROUND(AVG(distance_km), 2) AS avg_distance,
RANK() OVER(ORDER BY AVG(distance_km) DESC) AS distance_rank_user
FROM rides
GROUP BY user_id;

SELECT * FROM
(SELECT driver_id, SUM(distance_km) AS total_distance,
RANK() OVER(ORDER BY SUM(distance_km) DESC) AS rank_drivers
FROM rides
WHERE status='completed'
GROUP BY driver_id) t 
WHERE rank_drivers <= 5;

SELECT user_id, SUM(status LIKE 'cancelled%') AS total_cancelled_ride,
RANK() OVER(ORDER BY SUM(status LIKE 'cancelled%') DESC) AS rank_users
FROM rides
GROUP BY user_id;

SELECT DATE_FORMAT(ride_date, '%Y-%m') AS ride_month,
user_id, SUM(fare) AS total_spent,
RANK() OVER(PARTITION BY DATE_FORMAT(ride_date, '%Y-%m')
ORDER BY SUM(fare) DESC) AS monthly_rank
FROM rides
WHERE status = 'completed'
GROUP BY ride_month, user_id;