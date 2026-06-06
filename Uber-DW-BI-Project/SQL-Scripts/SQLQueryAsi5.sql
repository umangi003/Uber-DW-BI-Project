SELECT TOP 10
    trip_uid,
    accm_txn_create_time,
    accm_txn_complete_time,
    txn_process_time_hours
FROM Fact_Trip
WHERE txn_process_time_hours > 0