/* Step1: I first combined all the 6 tables into one using the UNION ALL syntax and created a new table combined_sixmonths_data */

CREATE TABLE JAN24_TILL_DEC24.combined_sixmonths_data AS  
(
  SELECT * FROM `finalcasestudy-454212.JAN24_TILL_DEC24.JAN24` UNION ALL
  SELECT * FROM `finalcasestudy-454212.JAN24_TILL_DEC24.FEB24` UNION ALL
  SELECT * FROM `finalcasestudy-454212.JAN24_TILL_DEC24.MAR24` UNION ALL
  SELECT * FROM `finalcasestudy-454212.JAN24_TILL_DEC24.APR24` UNION ALL
  SELECT * FROM `finalcasestudy-454212.JAN24_TILL_DEC24.NOV24` UNION ALL
  SELECT * FROM `finalcasestudy-454212.JAN24_TILL_DEC24.DEC24` 
)

/* Step 2: I checked if there are only 2 rideable types and yes there are only 2 */
  
SELECT DISTINCT rideable_type FROM `finalcasestudy-454212.JAN24_TILL_DEC24.combined_sixmonths_data` LIMIT 1000

/* STEP 3: Since we need only the trips that are shorter than a day and longer than a minute, I used the code,*/
  
SELECT * FROM `finalcasestudy-454212.JAN24_TILL_DEC24.combined_sixmonths_data` 
WHERE timestamp_diff(ended_at,started_at, MINUTE) >= 1 AND
timestamp_diff(ended_at, started_at, MINUTE) <= 1440
/* The result showed 1562293 rows out of 1598196 rows. So, 35903 rows needs to be removed.*/

/* STEP 4: I checked how many stations are there and their trips for both start and end station. There are total 1613 start stations and 1618 end stations */
SELECT start_station_name, count (*) AS no_of_trips
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.combined_sixmonths_data` 
GROUP BY start_station_name
ORDER BY start_station_name

SELECT end_station_name, count (*) AS no_of_trips
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.combined_sixmonths_data` 
GROUP BY end_station_name
ORDER BY end_station_name


