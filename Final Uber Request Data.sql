CREATE TABLE "Uber Data" (
    "Request id"                INTEGER,
    "Pickup point"              TEXT,
    "Driver id"                 INTEGER,
    "Status"                    TEXT,
    "Request timestamp"         TEXT,
    "Drop timestamp"            TEXT,
    "Trip Duration (hh:mm)"     TEXT,
    "Trip Duration (in mins)"   TEXT,
    "Trip Date"                 DATE,
    "Request Time"              TEXT,
    "Day Of Week"               TEXT,
    "Is Weekend"                TEXT,
    "Trip Completed"            TEXT,
    "Driver Assigned"           TEXT,
    "Trip Request Time Slot"    TEXT
);

select * from "Uber Data";

COPY "Uber Data"
FROM 'D:\Labmentix\Uber project 1\Final Uber Request Data.csv'
DELIMITER ','
CSV HEADER;


--1.Total Number of Trip Requests--
SELECT COUNT("Request id") AS "Total Requests"
FROM "Uber Data";


--2.Number of Trips Completed vs Not Completed--
SELECT "Trip Completed", COUNT(*) AS "Number of Trips"
FROM "Uber Data"
GROUP BY "Trip Completed";


--3.Daily Request Volume--
SELECT "Trip Date", COUNT(*) AS "Requests Per Day"
FROM "Uber Data"
GROUP BY "Trip Date"
ORDER BY "Trip Date";


--4.Number of Trip Requests by Time Slot--
SELECT "Trip Request Time Slot", COUNT(*) AS "Requests Per Slot"
FROM "Uber Data"
GROUP BY "Trip Request Time Slot"
ORDER BY "Requests Per Slot" DESC;


--5.Number of Requests from Each Pickup Point--
SELECT "Pickup point", COUNT(*) AS "Number of Requests"
FROM "Uber Data"
GROUP BY "Pickup point";


--6.Trips Completed by Each Driver--
SELECT "Driver id", COUNT(*) AS "Completed Trips"
FROM "Uber Data"
WHERE "Trip Completed" = 'Yes'
GROUP BY "Driver id";


--7.Average Trip Duration (in Minutes)--
SELECT AVG(CAST("Trip Duration (in mins)" AS INTEGER)) AS "Average Duration (mins)"
FROM "Uber Data"
WHERE "Trip Duration (in mins)" != 'NA';


--8.Trip Requests by Day of Week--
SELECT "Day Of Week", COUNT(*) AS "Trip Requests"
FROM "Uber Data"
GROUP BY "Day Of Week";


--9.Trips Without Drop Timestamp (Incomplete Trips)--
SELECT COUNT(*) AS "Trips Without Drop Time"
FROM "Uber Data"
WHERE "Drop timestamp" IS NULL;


--10.Most Active Drivers (Completed Trips Count)--
SELECT "Driver id", COUNT(*) AS "Completed Trips"
FROM "Uber Data"
WHERE "Trip Completed" = 'Yes'
GROUP BY "Driver id"
ORDER BY "Completed Trips" DESC;


--11.Status Breakdown of All Trips--
SELECT "Status", COUNT(*) AS "Status Count"
FROM "Uber Data"
GROUP BY "Status";


--12.Trips Requested in Evening Slot That Were Not Completed--
SELECT *
FROM "Uber Data"
WHERE "Trip Request Time Slot" = 'Evening'
  AND "Trip Completed" = 'No';


--13.Drivers Who Had More Than 5 Completed Trips--
SELECT "Driver id", COUNT(*) AS "Completed Trips"
FROM "Uber Data"
WHERE "Trip Completed" = 'Yes'
GROUP BY "Driver id"
HAVING COUNT(*) > 10;  


