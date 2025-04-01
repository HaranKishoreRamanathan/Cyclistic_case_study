/*STEP 1: For electric bikes, its not a problem for having null values as station name and id as they can be locked anywhere. But, classic bikes having null values in start_station_name, start_station_id, end_station_name, end_station_id needs to be deleted.*/ 
DELETE  
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.combined_sixmonths_data` 
WHERE rideable_type ='classic_bike' AND
start_station_name IS NULL OR
start_station_id IS NULL OR
end_station_name IS NULL OR
end_station_id IS NULL
/* This statement removed 394,875 rows from combined_sixmonths_data.*/

/*STEP 2: Remove rows containing null values in, start_lat, start_lng, end_lat and end_lng*/
DELETE FROM `finalcasestudy-454212.JAN24_TILL_DEC24.combined_sixmonths_data`
WHERE start_lat IS NULL OR
start_lng IS NULL OR
end_lat IS NULL OR
end_lng IS NULL

/*STEP 3: Delete trips that are shorter than a minute and longer than a day*/
DELETE 
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.combined_sixmonths_data` 
WHERE timestamp_diff(ended_at,started_at, MINUTE)  <=1 AND
timestamp_diff(ended_at, started_at, MINUTE) >= 1440

/*STEP 4: Create a column called ride_length. Calculate the length of each ride by subtracting the column started_at from the column ended_at. Create a column caled day_of_week, and calculate the day of the week that each ride started*/
SELECT *,
  TIMESTAMP_DIFF(ended_at, started_at,MINUTE) AS ride_length,
  MOD(EXTRACT(DAYOFWEEK FROM started_at) + 5, 7) + 1 AS day_of_week
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.combined_sixmonths_data` 

/*CLEANING IS DONE. ORIGINAL TABLE CONSISTED 1598196 ROWS. CLEANED TABLE CONSISTS 1203321 ROWS. 394875 rows were deleted*/
