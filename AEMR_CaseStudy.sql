#AEMR Case Study#
#Energy stability is one of the key themes the AEMR management team cares about. To ensure energy security and reliability, AEMR needs to understand the following:
#What are the most common outage types and how long do they tend to last?
#How frequently do the outages occur?
#Are there any energy providers that have more outages than their peers which may indicate that these providers are unreliable?

#QUERY 1
# Total NUmber of Outages in 2016 Uisng Status = 'Approved' 
SELECT COUNT(Status) AS Total_Number_Outage_Events,
Status, Outage_Reason
FROM AEMR.aemr_case
WHERE Start_Time = 2016
AND Status = 'Approved'
GROUP BY Outage_Reason
Order BY Outage_Reason;

#QUERY 2
# Total NUmber of Outages in 2017 Uisng Status = 'Approved'
SELECT COUNT(Status) AS Total_Number_Outage_Events, Status, Outage_Reason
FROM AEMR.aemr_case
WHERE Start_Time = 2017
AND Status = 'Approved'
GROUP BY Outage_Reason
Order BY Outage_Reason;

#QUERY 3
# Average Outage Duration in days for each Approved Outage_Reason from 2016-2017
SELECT  Status, outage_reason, Year(start_time) as Years, count(status) as Total_Number_Outages,
ROUND((AVG(TIMESTAMPDIFF(MINUTE, Start_Time, End_Time))/60)/24,2) Average_Outage_Duration_Time_Days
FROM AEMR.aemr_case
WHERE status = 'Approved'
GROUP by   Outage_Reason, Years;

#QUERY 4
# Total number Outages Events approved by Month for each Outage_Reason in 2016
SELECT Status, Outage_Reason, COUNT(STATUS) AS Total_Number_Outage_Events, MONTH(Start_Time) AS Months
FROM AEMR.aemr_case
WHERE Status = 'Approved' AND Start_Time = 2016
GROUP BY Outage_Reason, Months
Order BY Outage_Reason, Months;

#QUERY 5
# Total number Outages Events approved by Month for each Outage_Reason in 2017
SELECT Status, Outage_Reason, COUNT(Status) AS Total_Number_Outage_Events, MONTH(Start_Time) AS Months
FROM AEMR.aemr_case
WHERE Status = 'Approved' AND Start_Time = 2017
GROUP BY Outage_Reason, Months
Order BY Outage_Reason, Months;

#QUERY 6
# Total number for all approved Outage by Month for 2016-2017 
SELECT Status, COUNT(Status) AS Total_Number_Outage_Events, MONTH(Start_Time) AS Months,
YEAR(Start_Time) AS Years
FROM AEMR.aemr_case
WHERE Status = 'Approved'
GROUP BY Months, Years
Order BY Months, Years;

#QUERY 7
# Total count for all approved outage type by participant_code for 2016-2017
SELECT COUNT(Status) AS Total_Number_Outage_Events, Participant_Code, Status,
YEAR(Start_Time) AS Years
FROM AEMR.aemr_case
WHERE Status = 'Approved'
GROUP BY Participant_Code, Years
Order BY Participant_Code, Years;

#QUERY 8
# Average duration for all approved outage type by participant_code for 2016-2017
SELECT Participant_Code, Status, YEAR(Start_Time) AS Years,
ROUND((AVG(TIMESTAMPDIFF(MINUTE, Start_Time, End_Time))/60)/24,2) As Average_Outage_Duration_Time_Days
FROM AEMR.aemr_case
WHERE Status = 'Approved'
GROUP BY Participant_Code, Years
Order BY Average_Outage_Duration_Time_Days;

#QUERY 9
# Total count number of approved and outage type 'Forced' events for 2016-2017
SELECT Count(Status) AS Total_Number_Outage_Events, Outage_Reason, YEAR(Start_Time) AS Years
FROM AEMR.aemr_case
WHERE Status = 'Approved'
AND Outage_Reason = 'Forced'
GROUP BY Outage_Reason, Years
Order BY Outage_Reason, Years;

#QUERY 10
# Calculate the proportion of Outages for 'Forced' Eevnts in 2016-2017
SELECT
	SUM(CASE WHEN Outage_Reason = 'Forced' THEN 1 ELSE 0 END) AS Total_Number_Forced_Outage_Events,
	Count(Status) AS Total_Number_Outage_Events, ROUND(SUM(CASE WHEN Outage_Reason = 'Forced' THEN 1 ELSE 0 END) / Count(Status) * 100, 2) AS Forced_Outage_Percentage,
	YEAR(Start_Time) AS Years
FROM AEMR.aemr_case
WHERE Status = 'Approved'
GROUP BY Years
Order BY Years;

#QUERY 11
# Avegrage duartion Energy Loss MW for 'forced' outage in 2016-2017
SELECT Status, YEAR(Start_Time) AS Years, ROUND(AVG(Energy_Lost_MW), 2) AS Avg_Outage_MW_Loss,
ROUND(AVG(TIMESTAMPDIFF(MINUTE, Start_Time, End_Time)),2) As Average_Outage_Duration_Time_Minutes
FROM AEMR.aemr_case
WHERE Outage_Reason = 'Forced' AND Status = 'Approved'
GROUP BY Years
Order BY Years;

#QUERY 12
# Compare the average duration for each outage type in 2016-2017
SELECT Status, Outage_Reason, YEAR(Start_Time) AS Years,
ROUND(AVG(Energy_Lost_MW), 2) AS Avg_Outage_MW_Loss,
ROUND(AVG(TIMESTAMPDIFF(MINUTE, Start_Time, End_Time)),2) As Average_Outage_Duration_Time_Minutes
FROM AEMR.aemr_case
WHERE Status = 'Approved'
GROUP BY Years, Outage_Reason
Order BY Years;

#QUERY 13
# Average duration and energy loss MW for 'forced' outages by participant code
SELECT Participant_Code, Status, YEAR(Start_Time) AS Years,
ROUND(AVG(Energy_Lost_MW), 2) AS Avg_Outage_MW_Loss,
ROUND(((AVG(TIMESTAMPDIFF(MINUTE, Start_Time, End_Time)))/60)/24,2) As Average_Outage_Duration_Time_Days
FROM AEMR.aemr_case
WHERE Status = 'Approved' AND Outage_Reason = 'Forced'
GROUP BY Years, Participant_Code
Order BY Years, Avg_Outage_MW_Loss DESC;

#QUERY 14
# Average outage and summed Energy Loss MW by participant code for 'forced' outages in 2016-2017
SELECT Participant_Code, Facility_Code, Status, YEAR(Start_Time) AS Years,
ROUND(AVG(Energy_Lost_MW), 2) As Avg_Outage_MW_Loss,
ROUND(SUM(Energy_Lost_MW), 2) AS Summed_Energy_Lost
FROM AEMR.aemr_case
WHERE Status = 'Approved' AND Outage_Reason = 'Forced'
GROUP BY Years, Participant_Code, Facility_Code
Order BY Years, Summed_Energy_Lost DESC;


