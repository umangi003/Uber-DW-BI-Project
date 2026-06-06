SELECT TOP 10
    trip_uid,
    accm_txn_create_time,
    accm_txn_complete_time,
    DATEDIFF(hour, accm_txn_create_time, accm_txn_complete_time) AS calculated_hours
FROM Fact_Trip
WHERE accm_txn_create_time IS NOT NULL 
  AND accm_txn_complete_time IS NOT NULL;