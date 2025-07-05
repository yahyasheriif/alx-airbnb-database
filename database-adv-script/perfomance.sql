--  Write an initial query that retrieves all bookings along with the user details, property details, and payment details and save it on

SELECT *
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
LEFT JOIN properties p ON p.property_id = b.property_id
LEFT JOIN payments py ON py.booking_id = b.booking_id
WHERE b.status = 'confirmed' AND py.amount is NOT NULL;

EXPLAIN
ANALYZE
SELECT
    b.booking_id,
    b.status,
    u.user_id,
    u.first_name,
    p.property_id,
    p.country,
    py.payment_id,
    py.amount
FROM bookings b
JOIN users u ON b.user_id = u.user_id
LEFT JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments py ON b.booking_id = py.booking_id;

ANALYZE bookings, users, properties, payments;


EXPLAIN
SELECT *
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
LEFT JOIN properties p ON p.property_id = b.property_id
LEFT JOIN payments py ON py.booking_id = b.booking_id;

-- -- For INNER JOIN between bookings and users
-- CREATE INDEX idx_bookings_user_id ON bookings (user_id);
-- CREATE INDEX idx_users_user_id ON users (user_id);

-- -- For LEFT JOIN to properties
-- CREATE INDEX idx_bookings_property_id ON bookings (property_id);
-- CREATE INDEX idx_properties_property_id ON properties (property_id);

-- -- For LEFT JOIN to payments
-- CREATE INDEX idx_payments_booking_id ON payments (booking_id);
-- CREATE INDEX idx_bookings_booking_id ON bookings (booking_id);