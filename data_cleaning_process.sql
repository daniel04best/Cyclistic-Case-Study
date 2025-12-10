CREATE OR REPLACE TABLE `dark-passage-475919-b0.cyclistic_dataset.Cyclistic Data` AS
SELECT 
  ride_id, rideable_type, started_at, ended_at, member_casual, 
  -- Calculate ride length in minutes.
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_m,
  -- Get the day of the week of the start time. 
  EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week
-- using t1 alias to simplify code. 
 FROM `dark-passage-475919-b0.cyclistic_dataset.Cyclistic Data` AS t1
 WHERE
 -- cleaning null values in data
 t1.start_station_name IS NOT NULL
 AND t1.end_station_name IS NOT NULL
 -- removing outliers of rides under a minute and over 24 hours that were mistakes and shouldn't be accounted for. 
 AND TIMESTAMP_DIFF(t1.ended_at, t1.started_at, MINUTE) >= 1
 AND TIMESTAMP_DIFF(t1.ended_at, t1.started_at, MINUTE) <= 1440 



  
SELECT 
  member_casual, 
  ROUND(AVG(ride_length_m), 2) AS average_ride_length,
  ROUND(MAX(ride_length_m), 2) AS max_ride_length,
  ROUND(MIN(ride_length_m), 2) AS min_ride_length,
  COUNT(ride_id) AS total_trips

 FROM `dark-passage-475919-b0.cyclistic_dataset.Cyclistic Data` 
GROUP BY(member_casual)



SELECT 
-- analyzing by day of the week(1=Sunday, 2=Monday...)
day_of_week, member_casual,
AVG(ride_length_m) AS daily_average,
COUNT(ride_id) AS total_rides_per_day
 FROM `dark-passage-475919-b0.cyclistic_dataset.Cyclistic Data` 
-- to get daily average per day of the week, for both casual and member customers
GROUP BY member_casual, day_of_week
ORDER BY member_casual, day_of_week





SELECT 
-- analyzing seasonality by seeing results per month
member_casual,
AVG(ride_length_m) AS monthly_average_length,
COUNT(ride_id) AS total_rides_per_month,
EXTRACT(MONTH FROM started_at) AS month
 FROM `dark-passage-475919-b0.cyclistic_dataset.Cyclistic Data` 
-- to get daily average per day of the week, for both casual and member customers
GROUP BY member_casual,month
ORDER BY member_casual, month






SELECT
  DATE(started_at) AS ride_date,
  member_casual,
  
  AVG(ride_length_m) AS avg_duration,
  COUNT(ride_id) AS total_rides,
  EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week_num,
  FORMAT_DATE('%A', started_at) AS day_name,
  FORMAT_DATE('%Y-%m', started_at) AS ride_month

FROM
  `dark-passage-475919-b0.cyclistic_dataset.Cyclistic Data` 
  
GROUP BY
  ride_date, member_casual, day_of_week_num, day_name, ride_month
ORDER BY
  ride_date DESC

