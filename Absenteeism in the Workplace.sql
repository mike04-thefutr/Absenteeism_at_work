--left join, because we will bring back all the tables from the left 
-- we'll be joining three tables. compensation, reason, and our main table which is absenteeism at work. 
SELECT * FROM dbo.Absenteeism_at_work$ a
LEFT JOIN dbo.compensation$ b
ON a.ID = b.ID
LEFT JOIN dbo.Reasons$ c
ON a.Reason_for_absence = c.Number 

---find healthiest employees that we can give bonus 

SELECT * FROM dbo.Absenteeism_at_work$
WHERE Social_drinker = 0 and Social_smoker = 0 
and BMI < 25 and 
Absenteeism_time_in_hrs < (SELECT AVG(Absenteeism_time_in_hrs) FROM dbo.Absenteeism_at_work$ )

---compensation rate for employees that are non-smokers 
SELECT COUNT(*) AS non_smokers
FROM dbo.Absenteeism_at_work$
WHERE social_smoker = 0 
----there are 686 employeees who dont smoke, and may qualify for compensation rate 
--count(*),returns the number of rows that matches a specified criteria, use it with where clause to specify criteria 

---compensation rate for non-smokers/budget $983,221 so .68 increase per hour/ $1414.4 per year 
SELECT COUNT(*) AS non_smokers
FROM dbo.Absenteeism_at_work$
WHERE social_smoker = 0 

--optimize this query 
-- we dont want duplicate values 
SELECT a.ID, c.Reason
FROM dbo.Absenteeism_at_work$ a
LEFT JOIN dbo.compensation$ b
ON a.ID = b.ID
LEFT JOIN dbo.Reasons$ c
ON a.Reason_for_absence = c.Number 

--making categories within SQL using same query above

SELECT a.ID, c.Reason,
CASE WHEN Month_of_Absence IN (12,1,2) THEN 'Winter'
     WHEN Month_of_Absence IN (3,4,5) THEN 'Spring'
	 WHEN Month_of_Absence IN (6,7,8) THEN 'Summer'
	 WHEN Month_of_Absence IN (9,10,11) THEN 'Fall'
	 ELSE 'Unknown' END AS Season_Names 
FROM dbo.Absenteeism_at_work$ a
LEFT JOIN dbo.compensation$ b
ON a.ID = b.ID
LEFT JOIN dbo.Reasons$ c
ON a.Reason_for_absence = c.Number 
----------------------------------------------------------------------
-- we are creating another column 
--when u have mutiple case statement ensure that there is a comma at the end of it to let server know 
--just like when you add commas when you have a list of things to separate them 
SELECT a.ID, c.Reason, Month_of_Absence, BMI, 
CASE WHEN BMI < 18.5 THEN 'Underweight'
	 WHEN BMI BETWEEN 18.5 AND 25 THEN 'Healthy'
	 WHEN BMI BETWEEN 25 AND 30 THEN 'Overweight'
	 WHEN BMI > 30 THEN 'Obese'
	 ELSE 'Unknown' END AS BMI_Cateogory,
CASE WHEN Month_of_Absence IN (12,1,2) THEN 'Winter'
     WHEN Month_of_Absence IN (3,4,5) THEN 'Spring'
	 WHEN Month_of_Absence IN (6,7,8) THEN 'Summer'
	 WHEN Month_of_Absence IN (9,10,11) THEN 'Fall'
	 ELSE 'Unknown' END AS Season_Names 
FROM dbo.Absenteeism_at_work$ a
LEFT JOIN dbo.compensation$ b
ON a.ID = b.ID
LEFT JOIN dbo.Reasons$ c
ON a.Reason_for_absence = c.Number 


--now that we created our categories we need to now build our columns and bring other sections(data columns into current query)

SELECT a.ID, c.Reason, Month_of_Absence, BMI, 
CASE WHEN BMI < 18.5 THEN 'Underweight'
	 WHEN BMI BETWEEN 18.5 AND 25 THEN 'Healthy'
	 WHEN BMI BETWEEN 25 AND 30 THEN 'Overweight'
	 WHEN BMI > 30 THEN 'Obese'
	 ELSE 'Unknown' END AS BMI_Cateogory,
CASE WHEN Month_of_Absence IN (12,1,2) THEN 'Winter'
     WHEN Month_of_Absence IN (3,4,5) THEN 'Spring'
	 WHEN Month_of_Absence IN (6,7,8) THEN 'Summer'
	 WHEN Month_of_Absence IN (9,10,11) THEN 'Fall'
	 ELSE 'Unknown' END AS Season_Names,
Month_of_Absence, Day_of_the_week, Transportation_expense, Education, Son, Social_drinker, Social_smoker, Pet, Disciplinary_Failure, Age, Workload_Average_day, Absenteeism_time_in_hrs
FROM dbo.Absenteeism_at_work$ a
LEFT JOIN dbo.compensation$ b
ON a.ID = b.ID
LEFT JOIN dbo.Reasons$ c
ON a.Reason_for_absence = c.Number 

---lets format this query better 

SELECT 
  a.ID, 
  c.Reason, 
  Month_of_Absence, 
  BMI, 
  CASE WHEN BMI < 18.5 THEN 'Underweight' 
       WHEN BMI BETWEEN 18.5  AND 25 THEN 'Healthy'
       WHEN BMI BETWEEN 25  AND 30 THEN 'Overweight'
       WHEN BMI > 30 THEN 'Obese' 
  ELSE 'Unknown' END AS BMI_Cateogory, 
  CASE WHEN Month_of_Absence IN (12, 1, 2) THEN 'Winter' 
       WHEN Month_of_Absence IN (3, 4, 5) THEN 'Spring' 
	   WHEN Month_of_Absence IN (6, 7, 8) THEN 'Summer' 
	   WHEN Month_of_Absence IN (9, 10, 11) THEN 'Fall'
	   ELSE 'Unknown' END AS Season_Names, 
  Month_of_Absence, 
  Day_of_the_week, 
  Transportation_expense, 
  Education, 
  Son, 
  Social_drinker, 
  Social_smoker, 
  Pet, 
  Disciplinary_Failure, 
  Age, 
  Workload_Average_day, 
  Absenteeism_time_in_hrs 
FROM 
  dbo.Absenteeism_at_work$ a 
  LEFT JOIN dbo.compensation$ b ON a.ID = b.ID 
  LEFT JOIN dbo.Reasons$ c ON a.Reason_for_absence = c.Number

  --now were gonna use this query to bring this table into POWER BI 