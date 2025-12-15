# Find all cancelled rides with cancellation type and user name
SELECT r.ride_id, u.user_name, 
r.status AS cancellation_type, r.ride_date
FROM Rides r
JOIN Users u ON r.user_id = u.user_id
WHERE r.status <> 'completed';

# List drivers who have completed more than 5 rides
SELECT d.driver_id, d.driver_name, 
COUNT(r.ride_id) AS completed_rides
FROM drivers d
JOIN rides r ON d.driver_id = r.driver_id
WHERE r.status = 'completed'
GROUP BY d.driver_id, d.driver_name
HAVING COUNT(r.ride_id) > 3;

# Show users who have taken at least 2 ride along with total rides
SELECT u.user_id, u.user_name, 
COUNT(r.ride_id) AS total_rides
FROM users u 
JOIN rides r ON u.user_id = r.user_id
GROUP BY u.user_id, u.user_name
HAVING COUNT(r.ride_id) >= 2;