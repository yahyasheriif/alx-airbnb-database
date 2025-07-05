-- Identify high-usage columns in your User, Booking, and Property tables
-- Users -> email & role
-- Booking -> start_date & status & user_id
-- Property -> host-id & country & state &pricepernight

CREATE INDEX idx_bookings_start_date
ON bookings (start_date);

CREATE INDEX idx_bookings_status 
ON bookings (status);

CREATE INDEX idx_bookings_user_id 
ON bookings (user_id);

CREATE INDEX ind_properties_host_id
ON properties (host_id);

CREATE INDEX ind_properties_country
ON properties (country);

CREATE INDEX idx_properties_state
ON properties (state);

CREATE INDEX ind_properties_pricepernight
ON properties (pricepernight);


ALTER INDEX ind_properties_state
RENAME To idx_properties_state

DROP INDEX idx_bookings_start_date;

CREATE INDEX ind_bookings_total_price
ON bookings (total_price);

EXPLAIN ANALYZE SELECT * FROM bookings WHERE start_date = '2025-07-01';

EXPLAIN (ANALYZE, VERBOSE, BUFFERS) SELECT * FROM bookings WHERE total_price > 1900;

-- EXPLAIN ANALYZE SELECT * FROM bookings WHERE status = 'pending';

SELECT
    idx.relname AS index_name,
    tbl.relname AS table_name,
    idxs.indexdef AS index_definition
FROM
    pg_class idx
JOIN
    pg_index i ON idx.oid = i.indexrelid
JOIN
    pg_class tbl ON i.indrelid = tbl.oid
JOIN
    pg_indexes idxs ON idxs.indexname = idx.relname
WHERE
    NOT i.indisprimary
    AND NOT i.indisunique
    AND NOT idx.relname LIKE 'pg_%'
ORDER BY
    table_name, index_name;


-- SELECT
--     idx.relname AS index_name,
--     tbl.relname AS table_name,
--     idxs.indexdef AS index_definition
-- FROM
--     pg_class idx
-- JOIN
--     pg_index i ON idx.oid = i.indexrelid
-- JOIN
--     pg_class tbl ON i.indrelid = tbl.oid
-- JOIN
--     pg_indexes idxs ON idxs.indexname = idx.relname
-- WHERE
--     idx.relname NOT LIKE 'pg_%' -- excludes system indexes
-- ORDER BY
--     table_name, index_name;

