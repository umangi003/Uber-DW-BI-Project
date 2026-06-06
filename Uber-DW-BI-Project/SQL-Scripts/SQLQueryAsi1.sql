USE Uber_Assignment1;
TRUNCATE TABLE dbo.Fact_Trip;

INSERT INTO dbo.Fact_Trip (
    trip_uid, date_key, driver_key, vehicle_key,
    location_key, weather_key, rider_key,
    trip_status, trip_type, price_usd, distance_kms,
    trip_time, total_time, wait_time, surge_multiplier,
    accm_txn_create_time
)
SELECT 
    s.trip_uid,
    (SELECT TOP 1 date_key FROM dbo.Dim_Date
        WHERE date_key = CONVERT(INT, FORMAT(
            CONVERT(DATE, s.trip_end_time, 101),'yyyyMMdd'))) AS date_key,
    (SELECT TOP 1 driver_key FROM dbo.Dim_Driver
        WHERE driver_uid = s.driver_uid) AS driver_key,
    (SELECT TOP 1 vehicle_key FROM dbo.Dim_Vehicle
        WHERE vehicle_make = s.vehicle_make
        AND vehicle_model = s.vehicle_model) AS vehicle_key,
    (SELECT TOP 1 location_key FROM dbo.Dim_Location
        WHERE city = s.city AND country = s.country) AS location_key,
    (SELECT TOP 1 weather_key FROM dbo.Dim_Weather
        WHERE weather_main = s.weather_main
        AND weather_desc = s.weather_desc) AS weather_key,
    (SELECT TOP 1 rider_key FROM dbo.Dim_Rider
        WHERE rider_uid = s.rider_uid) AS rider_key,
    s.trip_status,
    s.trip_type,
    TRY_CAST(s.price_usd AS FLOAT),
    TRY_CAST(s.distance_kms AS FLOAT),
    s.trip_time,
    s.total_time,
    s.wait_time,
    TRY_CAST(s.surge_multiplier AS FLOAT),
    GETDATE()
FROM (
    SELECT *, ROW_NUMBER() OVER (
        PARTITION BY trip_uid ORDER BY trip_uid) AS rn
    FROM Uber_Staging.dbo.Stg_UberTrips
    WHERE trip_end_time IS NOT NULL
    AND ISDATE(trip_end_time) = 1
) s
WHERE s.rn = 1;

SELECT COUNT(*) AS Fact_Rows FROM uber_Assignment1.dbo.Fact_Trip;

SELECT trip_uid, COUNT(*) as cnt
FROM Uber_Staging.dbo.Stg_UberTrips
GROUP BY trip_uid
HAVING COUNT(*) > 1

