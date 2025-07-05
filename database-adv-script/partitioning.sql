-- Step 1: Create the parent partitioned table
DROP TABLE bookings_partitioned;

CREATE TABLE bookings_partitioned (
    booking_id UUID,
    user_id UUID,
    property_id UUID,
    status VARCHAR(50),
    start_date DATE NOT NULL,
    end_date DATE,
	PRIMARY KEY (booking_id, start_date),
    CONSTRAINT bookings_date_chk CHECK (start_date IS NOT NULL)
) PARTITION BY RANGE (start_date);

ALTER TABLE bookings_partitioned
ADD COLUMN total_price DECIMAL (10,2);



ANALYZE bookings_partitioned;

INSERT INTO bookings_partitioned (booking_id, user_id, property_id, status, start_date, end_date, total_price)
SELECT booking_id, user_id, property_id, status, start_date, end_date, total_price
FROM bookings;

EXPLAIN ANALYSE
SELECT * FROM bookings_partitioned;

-- Step 2: Create child partitions (example: yearly partitions)
CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 3: Add indexes on child partitions
CREATE INDEX idx_bookings_2023_start_date ON bookings_2023 (start_date);
CREATE INDEX idx_bookings_2024_start_date ON bookings_2024 (start_date);
CREATE INDEX idx_bookings_2025_start_date ON bookings_2025 (start_date);


EXPLAIN ANALYZE
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2025-03-01' AND '2025-03-31';

