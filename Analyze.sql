/*For analysing, I compared the two member types of everything including type of members/casuals for the type of ride, number of rides per month for the six months, number of rides per day and number of rides per hour, duration of the ride, start/end station name for both members and casuals.*/

/*Different ride types:*/
CREATE TABLE JAN24_TILL_DEC24.different_ride_type AS
SELECT rideable_type, member_casual, count (*) AS number_of_rides
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.cleaned_data` 
GROUP BY rideable_type, member_casual
ORDER BY rideable_type, member_casual

/*Number of rides per month:*/
CREATE TABLE JAN24_TILL_DEC24.no_of_rides_permonth AS 
SELECT member_casual, EXTRACT(MONTH FROM started_at) AS month, count(*) AS no_of_rides_pm
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.cleaned_data`
GROUP BY member_casual, month
ORDER BY member_casual, month

/*Number of rides per day:*/
CREATE TABLE JAN24_TILL_DEC24.no_of_rides_perday AS 
SELECT member_casual, day_of_week, count(*) AS no_of_rides_pd
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.cleaned_data`
GROUP BY member_casual, day_of_week
ORDER BY member_casual, day_of_week

/*Number of rides per hour:*/
CREATE TABLE JAN24_TILL_DEC24.no_of_rides_permonth AS 
SELECT member_casual, EXTRACT(HOUR FROM started_at) AS HOUR, count(*) AS no_of_rides_ph
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.cleaned_data`
GROUP BY member_casual, month
ORDER BY member_casual, month

/*Average duration:*/
SELECT 
    day_of_week,
    member_casual,
    ROUND(AVG(TIMESTAMP_DIFF(ended_at, started_at, MINUTE)), 2) AS avg_ride_duration_min
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.cleaned_data`
GROUP BY day_of_week, member_casual
ORDER BY day_of_week, member_casual;


/*Start/end station name for both members and casuals:*/

/*Starting station name for casual:*/
CREATE TABLE JAN24_TILL_DEC24.starting_station_casual AS
SELECT 
  start_station_name, count (*) AS no_of_rides
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.cleaned_data`
WHERE member_casual = 'casual' 
GROUP BY start_station_name 

/*Starting station name for member:*/
CREATE TABLE JAN24_TILL_DEC24.starting_station_member AS
SELECT 
  start_station_name, count (*) AS no_of_rides
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.cleaned_data`
WHERE member_casual = 'member' 
GROUP BY start_station_name 

/*Ending station name for casuals:*/
CREATE TABLE JAN24_TILL_DEC24.ending_station_casual AS
SELECT 
  end_station_name, count (*) AS no_of_rides
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.cleaned_data`
WHERE member_casual = 'casual' 
GROUP BY end_station_name 

/*Ending station name for members:*/
CREATE TABLE JAN24_TILL_DEC24.ending_station_member AS
SELECT 
  end_station_name, count (*) AS no_of_rides
FROM `finalcasestudy-454212.JAN24_TILL_DEC24.cleaned_data`
WHERE member_casual = 'member' 
GROUP BY end_station_name 

/*Lastly I combined the starting stations and ending stations for both members and casuals for easy visualization*/
CREATE TABLE finalcasestudy-454212.JAN24_TILL_DEC24.starting_station_casualmember AS 
SELECT start_station_name, no_of_rides, 'casual' AS category FROM `finalcasestudy-454212.JAN24_TILL_DEC24.starting_station_casual` union all
SELECT start_station_name, no_of_rides, 'member' AS category FROM `finalcasestudy-454212.JAN24_TILL_DEC24.starting_station_member`

CREATE TABLE finalcasestudy-454212.JAN24_TILL_DEC24.ending_station_casualmember AS 
SELECT end_station_name, no_of_rides, 'casual' AS category FROM `finalcasestudy-454212.JAN24_TILL_DEC24.ending_station_casual` union all
SELECT end_station_name, no_of_rides, 'member' AS category FROM `finalcasestudy-454212.JAN24_TILL_DEC24.ending_station_member`
