-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.

SELECT p.name, r.rating
FROM Properties p
LEFT JOIN reviews r ON p.property_id = r.property_id
WHERE p.property_id IN (
    SELECT property_id
    FROM Reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

--  Write a correlated subquery to find users who have made more than 3 bookings.


SELECT u.user_id, u.first_name, u.last_name
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;