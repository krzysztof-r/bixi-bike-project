# Bixi Bike Analysis

Bixi Bike Analysis Deliverable

# Bixi Project - Part 1 - Data Analysis in SQL
This unit project consists of two deliverables. In the first deliverable we will use what we learned about SQL to dig into the Bixi dataset. While in the second deliverable we will further explore the data using Tableau and consistent with the visualization principles highlighted in lecture. Our goal is to gain a high level understanding of how people use Bixi bikes, what factors influence the volume of usage, popular stations and overall business growth.

The data is a cleaned up version of data downloaded from the open data portal at Bixi Montreal: https://www.bixi.com/en/open-data

Run the SQL file located here.

Question 1
First, we will attempt to gain an overall view of the volume of usage of Bixi Bikes and what factors influence it.

The total number of trips for the years of 2016.

The total number of trips for the years of 2017.

The total number of trips for the years of 2016 broken-down by month.

The total number of trips for the years of 2017 broken-down by month.

The average number of trips a day for each year-month combination in the dataset.

Save your query results from the previous question (Q1.5) by creating a table called working_table1.

Question 2
Unsurprisingly, the number of trips varies greatly throughout the year. How about membership status? Should we expect member and non-member to behave differently? To start investigating that, calculate:

The total number of trips in the year 2017 broken-down by membership status (member/non-member).

The fraction of total trips that were done by members for the year of 2017 broken-down by month.

Question 3
Use the above queries to answer the questions below.

Which time of the year the demand for Bixi bikes is at its peak?

If you were to offer non-members a special promotion in an attempt to convert them to members, when would you do it?

Question 4
It is clear now that average temperature and membership status are intertwined and influence greatly how people use Bixi bikes. Let’s try to bring this knowledge with us and learn something about station popularity.

What are the names of the 5 most popular starting stations? Solve this problem without using a subquery.

Solve the same question as Q4.1, but now use a subquery. Is there a difference in query run time between 4.1 and 4.2?

Question 5
If we break-up the hours of the day as follows:

SELECT CASE
       WHEN HOUR(start_date) BETWEEN 7 AND 11 THEN "morning"
       WHEN HOUR(start_date) BETWEEN 12 AND 16 THEN "afternoon"
       WHEN HOUR(start_date) BETWEEN 17 AND 21 THEN "evening"
       ELSE "night"
       END AS "time_of_day",
       ...
How is the number of starts and ends distributed for the station Mackay / de Maisonneuve throughout the day?

Explain the differences you see and discuss why the numbers are the way they are.

Question 6
List all stations for which at least 10% of trips are round trips. Round trips are those that start and end in the same station. This time we will only consider stations with at least 500 starting trips. (Please include answers for all steps outlined here)

First, write a query that counts the number of starting trips per station.

Second, write a query that counts, for each station, the number of round trips.

Combine the above queries and calculate the fraction of round trips to the total number of starting trips for each station.

Filter down to stations with at least 500 trips originating from them and having at least 10% of their trips as round trips.

Where would you expect to find stations with a high fraction of round trips?
