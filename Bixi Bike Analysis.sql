/***** Bixi Bike Analysis *****/

-- Question 1
-- First, we will attempt to gain an overall view of the volume of usage of Bixi Bikes and what factors influence it.

-- The total number of trips for the years of 2016.
SELECT YEAR(start_date) AS Year, COUNT(*) AS "Total Trips 2016"
FROM trips
WHERE YEAR(start_date) = "2016";

-- The total number of trips for the years of 2017.
SELECT YEAR(start_date) AS Year, COUNT(*) AS "Total Trips 2017"
FROM trips
WHERE YEAR(start_date) = "2017";

-- The total number of trips for the years of 2016 broken-down by month.
SELECT MONTH(start_date) AS Month, COUNT(*) AS "Total Trips 2016"
FROM trips
WHERE YEAR(start_date) = "2016" AND MONTH(start_date) > "00"
GROUP BY MONTH(start_date);

-- The total number of trips for the years of 2017 broken-down by month.
SELECT MONTH(start_date) AS Month, COUNT(*) AS "Total Trips 2017"
FROM trips
WHERE YEAR(start_date) = "2017" AND MONTH(start_date) > "00"
GROUP BY MONTH(start_date);

-- The average number of trips a day for each year-month combination in the dataset.
SELECT YEAR(start_date) AS Year, MONTH(start_date) AS Month, ROUND(COUNT(*) / COUNT(DISTINCT DAY(start_date)), 0) AS Average_Trips
FROM trips
GROUP BY Year, Month
ORDER BY Year, Month ASC;

-- Save your query results from the previous question (Q1.5) by creating a table called working_table1.
DROP TABLE IF EXISTS working_table1;
CREATE TABLE working_table1 (Year INT, Month INT, Average_Trips INT)
SELECT YEAR(start_date) AS Year, MONTH(start_date) AS Month, COUNT(*) / COUNT(DISTINCT DAY(start_date)) AS Average_Trips
FROM trips
GROUP BY Year, Month
ORDER BY Year, Month ASC;

-- Question 2
-- Unsurprisingly, the number of trips varies greatly throughout the year. How about membership status? Should we expect member and non-member to behave differently? To start investigating that, calculate:

-- The total number of trips in the year 2017 broken-down by membership status (member/non-member).
SELECT YEAR(start_date) AS Year, is_member AS Membership_Status, COUNT(*) AS Total_Trips
FROM trips
WHERE YEAR(start_date) = "2017"
GROUP BY Membership_Status;

-- The fraction of total trips that were done by members for the year of 2017 broken-down by month.
SELECT YEAR(start_date) AS Year, MONTH(start_date) AS Month, is_member AS Membership_Status, ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM trips WHERE YEAR(start_date) = "2017" AND is_member = 1), 2) AS fract_calc
FROM trips
WHERE YEAR(start_date) = "2017" AND is_member = 1
GROUP BY Month
ORDER BY fract_calc DESC;

-- Question 3
-- Use the above queries to answer the questions below.

-- Which time of the year the demand for Bixi bikes is at its peak?
-- Bixi bike demand was at its peak in the month of July followed by August, September, and June.

-- If you were to offer non-members a special promotion in an attempt to convert them to members, when would you do it?
-- April

-- Question 4
-- It is clear now that average temperature and membership status are intertwined and influence greatly how people use Bixi bikes. Let’s try to bring this knowledge with us and learn something about station popularity.

-- What are the names of the 5 most popular starting stations? Solve this problem without using a subquery.
SELECT trips.start_station_code AS Station_Code, stations.name AS Station_Name, COUNT(*) AS Total_Trips
FROM trips
INNER JOIN stations
	ON stations.code = trips.start_station_code
GROUP BY start_station_code
ORDER BY Total_Trips DESC
LIMIT 5;

-- Solve the same question as Q4.1, but now use a subquery. Is there a difference in query run time between 4.1 and 4.2? ************
SELECT trips.start_station_code AS Station_Code, stations.name AS Station_Name, Trips_ct, RANK() OVER (PARTITION BY stations.code ORDER BY Trips_ct DESC) AS popular_station
FROM
(
	SELECT trips.start_station_code, COUNT(*) AS Trips_ct
	FROM trips
	INNER JOIN stations
		ON stations.code = trips.start_station_code
	GROUP BY start_station_code
) AS Total_Trips;

-- Question 5
-- If we break-up the hours of the day as follows:

-- SELECT CASE
--        WHEN HOUR(start_date) BETWEEN 7 AND 11 THEN "morning"
--        WHEN HOUR(start_date) BETWEEN 12 AND 16 THEN "afternoon"
--        WHEN HOUR(start_date) BETWEEN 17 AND 21 THEN "evening"
--        ELSE "night"
--        END AS "time_of_day",
--        ...
-- How is the number of starts and ends distributed for the station Mackay / de Maisonneuve throughout the day?
SELECT stations.code, stations.name , trips.start_date, trips.end_date, COUNT(*) AS dist_ct, ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM trips WHERE stations.code = 6100), 2) AS dist_ct,
	CASE
    WHEN HOUR(start_date) BETWEEN 7 AND 11 THEN "morning"
	WHEN HOUR(start_date) BETWEEN 12 AND 16 THEN "afternoon"
	WHEN HOUR(start_date) BETWEEN 17 AND 21 THEN "evening"
	ELSE "night"
	END AS time_of_day
FROM trips
INNER JOIN stations
	ON stations.code = trips.start_station_code
WHERE stations.code = 6100
GROUP BY time_of_day
ORDER BY dist_ct DESC;

SELECT start_station_code, COUNT(*) AS Total_Trips, ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM trips WHERE start_station_code = 6100), 2) AS dist_ct,
	CASE
    WHEN HOUR(start_date) BETWEEN 7 AND 11 THEN "morning"
	WHEN HOUR(start_date) BETWEEN 12 AND 16 THEN "afternoon"
	WHEN HOUR(start_date) BETWEEN 17 AND 21 THEN "evening"
	ELSE "night"
	END AS time_of_day
FROM trips
WHERE start_station_code = 6100
GROUP BY time_of_day
ORDER BY dist_ct DESC;

SELECT stations.code, stations.name , trips.start_date, trips.end_date, COUNT(*) AS dist_ct, ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM trips WHERE stations.code = 6100), 2) AS dist_ct,
	CASE
    WHEN HOUR(end_date) BETWEEN 7 AND 11 THEN "morning"
	WHEN HOUR(end_date) BETWEEN 12 AND 16 THEN "afternoon"
	WHEN HOUR(end_date) BETWEEN 17 AND 21 THEN "evening"
	ELSE "night"
	END AS time_of_day
FROM trips
INNER JOIN stations
	ON stations.code = trips.end_station_code
WHERE stations.code = 6100
GROUP BY time_of_day
ORDER BY dist_ct DESC;

SELECT end_station_code, COUNT(*) AS Total_Trips, ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM trips WHERE end_station_code = 6100), 2) AS dist_ct,
	CASE
    WHEN HOUR(end_date) BETWEEN 7 AND 11 THEN "morning"
	WHEN HOUR(end_date) BETWEEN 12 AND 16 THEN "afternoon"
	WHEN HOUR(end_date) BETWEEN 17 AND 21 THEN "evening"
	ELSE "night"
	END AS time_of_day
FROM trips
WHERE end_station_code = 6100
GROUP BY time_of_day
ORDER BY dist_ct DESC;

SELECT *
FROM trips;

-- Explain the differences you see and discuss why the numbers are the way they are.
-- It appears majority of the start trips for Station Code 6100 occur during the evening, between the times of 5 PM and 9 PM followed by Afternoon, Morning, and then Night.
-- It can also be said that traffic pick up throughout the day beginning in the afternoon and peaking in the evening.

-- It appears majority of the end trips for Station Code 6100 occur during the evening, between the times of 5 PM and 9 PM followed very closely by Afternoon, Morning, and then Night.
-- It can also be said that traffic is consistently busy throughout the day beginning in the morning and peaking in the afternoon and evening.

-- Question 6
-- List all stations for which at least 10% of trips are round trips. Round trips are those that start and end in the same station. This time we will only consider stations with at least 500 starting trips. 
-- (Please include answers for all steps outlined here)

-- First, write a query that counts the number of starting trips per station.
SELECT start_station_code, end_station_code, stations.name AS Station_Name, COUNT(*) AS Total_Starting_Trips
FROM trips
INNER JOIN stations
	ON stations.code = trips.start_station_code
GROUP BY start_station_code
ORDER BY start_station_code ASC;

-- Second, write a query that counts, for each station, the number of round trips.
SELECT start_station_code, end_station_code, stations.name AS Station_Name, COUNT(*) AS Round_Trips
FROM trips
INNER JOIN stations
	ON stations.code = trips.start_station_code
WHERE start_station_code = end_station_code
GROUP BY start_station_code
ORDER BY start_station_code ASC;

-- Combine the above queries and calculate the fraction of round trips to the total number of starting trips for each station.
SELECT a.start_station_code AS Starting_Station_Code, a.Round_Trips AS Total_Round_Trips, b.Total_Starting_Trips AS Total_Starting_Trips, ROUND(100 * a.Round_Trips / b.Total_Starting_Trips, 2) AS Round_over_Total_Trips
FROM
(
SELECT start_station_code, end_station_code, stations.name AS Station_Name, COUNT(*) AS Round_Trips
FROM trips
INNER JOIN stations
	ON stations.code = trips.start_station_code
WHERE start_station_code = end_station_code
GROUP BY start_station_code
ORDER BY start_station_code ASC
) AS a,
(
SELECT start_station_code, end_station_code, stations.name AS Station_Name, COUNT(*) AS Total_Starting_Trips
FROM trips
INNER JOIN stations
	ON stations.code = trips.start_station_code
WHERE NOT start_station_code = end_station_code OR start_station_code = end_station_code
GROUP BY start_station_code
ORDER BY start_station_code ASC
) AS b
WHERE a.start_station_code = b.start_station_code
GROUP BY a.start_station_code
LIMIT 20;

-- Filter down to stations with at least 500 trips originating from them and having at least 10% of their trips as round trips.
SELECT a.start_station_code AS Starting_Station_Code, a.Round_Trips AS Total_Round_Trips, b.Total_Starting_Trips AS Total_Starting_Trips, ROUND(100 * a.Round_Trips / b.Total_Starting_Trips, 2) AS Round_over_Total_Trips
FROM
(
SELECT start_station_code, end_station_code, stations.name AS Station_Name, COUNT(*) AS Round_Trips
FROM trips
INNER JOIN stations
	ON stations.code = trips.start_station_code
WHERE start_station_code = end_station_code
GROUP BY start_station_code
ORDER BY start_station_code ASC
) AS a,
(
SELECT start_station_code, end_station_code, stations.name AS Station_Name, COUNT(*) AS Total_Starting_Trips
FROM trips
INNER JOIN stations
	ON stations.code = trips.start_station_code
GROUP BY start_station_code
ORDER BY start_station_code ASC
) AS b
WHERE a.start_station_code = b.start_station_code AND Total_Starting_Trips >= 500 AND ROUND(100 * a.Round_Trips / b.Total_Starting_Trips, 2) >= 10.00
GROUP BY a.start_station_code
ORDER BY b.Total_Starting_Trips, Round_over_Total_Trips DESC;

SELECT a.* FROM (
SELECT start_station_code, COUNT(*) AS total_ct 
FROM trips
GROUP BY start_station_code) AS a
WHERE a.total_ct >= 500;

-- Where would you expect to find stations with a high fraction of round trips?