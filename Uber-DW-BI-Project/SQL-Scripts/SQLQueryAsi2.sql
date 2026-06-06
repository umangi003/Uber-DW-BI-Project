CREATE PROCEDURE dbo.Load_DimDate AS
BEGIN
  DECLARE @d DATE = '2015-01-01'
  WHILE @d <= '2018-12-31'
  BEGIN
    IF NOT EXISTS (SELECT 1 FROM Dim_Date WHERE full_date = @d)
      INSERT INTO Dim_Date(
        date_key,
        full_date,
        day,
        month,
        year,
        quarter,
        weekday)
      VALUES(
        CAST(CONVERT(VARCHAR, @d, 112) AS INT),
        @d,
        DAY(@d),
        MONTH(@d),
        YEAR(@d),
        DATEPART(q,@d),
        DATENAME(weekday,@d))
    SET @d = DATEADD(day,1,@d)
  END
END
GO

CREATE PROCEDURE dbo.Upsert_DimVehicle
  @make VARCHAR(50), @model VARCHAR(50),
  @make_model VARCHAR(100), @plate VARCHAR(50)
AS BEGIN
  IF NOT EXISTS (SELECT 1 FROM Dim_Vehicle 
    WHERE vehicle_make=@make AND vehicle_model=@model)
    INSERT INTO Dim_Vehicle(vehicle_make,vehicle_model,
      vehicle_make_model,vehicle_license_plate)
    VALUES(@make,@model,@make_model,@plate)
END
GO

CREATE PROCEDURE dbo.Upsert_DimLocation
    @city NVARCHAR(100), @country NVARCHAR(50),
    @start_addr NVARCHAR(300), @end_addr NVARCHAR(300)
AS BEGIN
    IF NOT EXISTS (SELECT 1 FROM Dim_Location
        WHERE trip_start_address=@start_addr
        AND trip_end_address=@end_addr)
        INSERT INTO Dim_Location(city,country,
            trip_start_address,trip_end_address)
        VALUES(@city,@country,@start_addr,@end_addr)
END
GO