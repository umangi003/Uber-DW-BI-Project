SELECT COUNT(*) AS trip_rows
FROM Uber_Staging.dbo.Stg_DriverDetails;

SELECT COUNT(*) AS trip_rows
FROM Uber_Staging.dbo.Stg_UberTrips;

DELETE FROM Uber_Staging.dbo.Stg_Weather;

INSERT INTO Uber_Staging.dbo.Stg_Weather (
    temperature_time, temperature_value, feels_like,
    humidity, wind_speed, cloudness,
    weather_main, weather_desc, precipitation
)
SELECT
    temperature_time,
    TRY_CAST(temperature_value AS SMALLINT),
    TRY_CAST(feels_like        AS SMALLINT),
    TRY_CAST(humidity          AS FLOAT),
    TRY_CAST(wind_speed        AS FLOAT),
    TRY_CAST(cloudness         AS FLOAT),
    weather_main,
    weather_desc,
    precipitation
FROM Uber_Staging.dbo.Stg_UberTrips
WHERE weather_main IS NOT NULL;

SELECT COUNT(*) FROM Uber_Staging.dbo.Stg_Weather;

