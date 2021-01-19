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

# Bixi Project - Part 2 - Visual Analytics in Tableau
In the first deliverable for this unit you explored using SQL queries to generate insights from a real-world dataset stored in a relational database. For this deliverable, you will create data visualizations using Tableau, allowing the user to interactively derive business insights from the same dataset without having to write code.

You'll be working with different individuals at the Bixi organization who all have their own business questions and are relying on you, as a visual analytics specialist, to help answer them by pulling insights from the trip data.

Setup
You will want to connect Tableau to your MySQL database and link the trip and station data. To do this, navigate to the data source sheet in Tableau and select MySQL under 'Connect to a Server':

Figure 1
Enter your login information for your local MySQL instance:

Figure 2
In the Data Source sheet, select the bixi schema. Make sure the connection type is set to Live. Drag the trips table onto the canvas. Click the down arrow on the trips table or right click to bring up the context menu, and select 'Open':

Figure 3
Now drag the stations table inside and drop it to the right of the trips table:

Figure 4
Click on the connecting relationship and ensure that the join is between start_station_code in the trips table and code in the stations table and that the join type is set to Inner:

Figure 5
Click 'Update Now'

Figure 6
You many now click into a worksheet and begin building visualizations.

Question 1
Here we will duplicate and extend some of the insights performed in the first deliverable, without the need for writing SQL code. The BI manager has specifically directed you to deliver the following for the meeting on Monday:

Build a visualization to contrast the total number of monthly trips for the calendar years of 2016 and 2017 by month. What differences do you notice about the usage of the Bixi service between the two years?

Use a quick calculation to contrast the percentage of trips that occurred in each month per year, between 2016 and 2017; e.g. if 1000 trips occurred in 2017 in total, and 120 of them occurred in July, then July has 12% of trips in 2017. How does the proportional monthly usage differ between 2016 and 2017?

Make a calculated field to calculate the percentage of trips that were done by members, and using this, visualize what percentage of trips per month were member trips for the year 2017.

Create a calculated field for identifying round trips (hint: you will need to use a calculated field with conditionals). Create a visualization showing the top 10 stations by percentage of round trips.

Question 2
The marketing team is interested in how people use the Bixi service - specifically, are they mainly taking long trips or short trips? What is the relationship between round trips and member trips at the station level? Do behaviors vary between members and non-members or by station?

Build a visualization for marketing showing the relationship between percentage of round trips and percentage of member trips by station. Comment upon/interpret any interesting patterns you see.

Make a histogram (or histograms) to visualize the distribution of all trips by duration in minutes, and contrast this between member and non-member trips. What can be said about the behavior of members vs. non-members in terms of trip length?

Create a map to visualize the average trip duration per station across the city. Are there any interesting geographic patterns you notice? Why do you think this might this be?

Question 3
While the revenue Bixi generates from their members, and 1-day and 3-days passes is fairly well understood by the business, they would like to get a better understanding of the revenue generated by infrequent users who make single, shorter trips an hour long or less. The pricing model for single trips is as follows:

$2.99 flat rate for each trip that is 30 minutes or less
$4.79 ($2.99 + $1.80) for trips greater than 30 minutes, up to 45 minutes in length
$7.79 ($2.99 + $1.80 + $3) for trips greater than 45 minutes, up to 60 minutes
Note: You may assume every non-member trip is a single trip, subject to the pricing model above.

Given this information:

Create a calculated field (or fields) to calculate the revenue generated by this pricing model.

What are the total dollar amounts and relative percentage of revenue from single trips up to an hour in length for each of the three different pricing buckets above?

The Director of Finance is not satisifed with the above insights, and wants very detailed information on exactly when they are seeing the most revenue from single trips 30 minutes or less. Create a visualization to show the total amount of flat rate revenue in the data for each hour and each day of week (Monday, Tuesday, Wednesday, etc.). At which days/times is Bixi generating the most revenue from their flat rate charge? You may use a new calculated field for this question

Question 4
Finally, the operations team wants an interactive reporting dashboard they can use to drill into the data and get out insights as required, as well as fulfill lots of ad hoc data requests for data that they receive.

Create a dashboard containing at least 3 visualizations, using two you've already created thus far as well as one additional new one of your choosing.


