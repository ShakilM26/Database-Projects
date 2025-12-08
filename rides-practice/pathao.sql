SELECT r.ride_id, r.ride_date, u.user_name, d.driver_name,  
r.distance_km, r.fare FROM rides r
JOIN users u ON u.user_id = r.user_id
JOIN drivers d ON d.driver_id = r.driver_id;

SELECT r.ride_id, r.ride_date, u.user_name, 
d.driver_name, r.status FROM rides r 
JOIN users u ON u.user_id = r.user_id
JOIN drivers d ON d.driver_id = r.driver_id
WHERE r.status = 'completed'; 

SELECT r.ride_id, u.user_name, r.status AS cancellation_type,
r.ride_date FROM rides r 
JOIN users u ON u.user_id = r.user_id
WHERE r.status <> 'completed'; 

SELECT r.ride_id, r.ride_date, u.user_name, u.signup_date, 
d.driver_name, d.join_date, r.distance_km, r.fare
FROM rides r
JOIN users u ON u.user_id = r.user_id
JOIN drivers u ON d.driver_id = r.driver_id; 

SELECT u.user_id, u.user_name, COUNT(r.ride_id) AS total_rides
FROM users u
JOIN rides r ON u.user_id = r.user_id
GROUP BY u.user_id, u.user_name;

SELECT d.driver_id, d.driver_name, COUNT(r.ride_id) AS completed_rides
FROM rides r
JOIN drivers d ON d.driver_id = r.driver_id 
WHERE r.status = 'completed'
GROUP BY d.driver_id, d.driver_name
HAVING COUNT(r.ride_id) >= 5;

/* # Aggregation  ************************************************** /*
SELECT u.user_id, u.user_name, COUNT(r.ride_id) AS total_rides
FROM users u
JOIN rides r ON u.user_id = r.user_id
GROUP BY u.user_id, u.user_name;

SELECT d.driver_id, d.driver_name, SUM(r.fare) AS revenue
FROM drivers d
JOIN rides r ON d.driver_id = r.driver_id
WHERE status = 'completed'
GROUP BY d.driver_id, d.driver_name 
ORDER BY revenue DESC;

SELECT u.user_id, u.user_name, 
ROUND(AVG(r.distance_km), 2) AS Average_Ride_Distance 
FROM users u
JOIN rides r ON u.user_id = r.user_id
GROUP BY u.user_id, u.user_name;

SELECT ride_date, SUM(status='completed') AS completed_rides, 
SUM(status LIKE 'cancelled%') AS cancelled_rides
FROM rides
GROUP BY ride_date
ORDER BY ride_date;

SELECT ride_date, SUM(fare) AS total_revenue
FROM rides
WHERE status='completed'
GROUP BY ride_date
ORDER BY total_revenue DESC;