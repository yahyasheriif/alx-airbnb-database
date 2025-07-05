SELECT a.user_id, a.first_name, b.booking_id 
FROM users a
INNER JOIN bookings b ON a.user_id = b.user_id;

SELECT * 
FROM properties a
LEFT JOIN reviews b ON a.property_id = b.property_id
ORDER BY b.rating;

SELECT * 
FROM users u
FULL OUTER JOIN bookings b ON u.user_id = b.user_id;

