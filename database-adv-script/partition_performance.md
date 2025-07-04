# Report Template: Performance Improvements

Performance Report: Bookings Table Partitioning

Objective: Improve query performance on a large bookings table by partitioning it based on start_date.

Implementation:

Created parent table with RANGE partitioning on start_date.

Added yearly partitions for 2023, 2024, and 2025.

Applied indexes to start_date on each child partition.

Query Used:

```sql
    SELECT *
    FROM bookings_partitioned
    WHERE start_date BETWEEN '2025-03-01' AND '2025-03-31';
```

## Observations:

Before Partitioning: The planner performed a full sequential scan over the entire table.

After Partitioning: The query planner scanned only the relevant partition (bookings_2025), reducing I/O and execution time.

Improved Execution Time: Dropped from ~120ms to ~25ms (varies by system).

## Conclusion: 

Partitioning greatly improved query efficiency for date-specific bookings. This technique is highly recommended for large datasets with temporal patterns.