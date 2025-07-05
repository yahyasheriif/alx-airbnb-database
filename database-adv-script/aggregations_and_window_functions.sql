-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

SELECT user_id, count(booking_id) as total_number_of_bookings
FROM bookings
GROUP BY user_id;

SELECT u.first_name, u.last_name, count(booking_id) as total_number_of_bookings
FROM bookings b
LEFT JOIN users u ON b.user_id = u.user_id
GROUP BY u.first_name, u.last_name;

-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.

SELECT 
  property_id,
  total_bookings,
  ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS rank
FROM (
  SELECT 
    property_id,
    COUNT(booking_id) AS total_bookings
  FROM bookings
  GROUP BY property_id
) AS booking_counts;

SELECT 
  property_id,
  total_bookings,
  RANK() OVER (ORDER BY total_bookings DESC) as rank  
FROM (
	SELECT property_id, count(booking_id) as total_bookings
	FROM bookings
	GROUP BY property_id
);

