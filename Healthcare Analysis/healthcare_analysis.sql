-- 1. Find the total billing amount for each medical condition.
SELECT Medical_Condition, SUM(Billing_Amount) AS Total_Billing_Amount
FROM healthcare_dataset
GROUP BY Medical_Condition;

-- 2. List the top 5 most common blood types in the hospital.
SELECT Blood_Type, COUNT(*) AS Blood_Type_Count FROM healthcare_dataset
GROUP BY Blood_Type ORDER BY Blood_Type_Count DESC LIMIT 5;

-- 3. Find the average billing amount for patients with each medical condition.
SELECT Medical_Condition, AVG(Billing_Amount) AS Average_Billing_Amount 
FROM healthcare_dataset 
GROUP BY Medical_Condition;

-- 4. Retrieve the patients who were admitted and discharged within the same month.
SELECT Name, Date_of_Admission, Discharge_Date
FROM healthcare_dataset
WHERE MONTH(Date_of_Admission) = MONTH(Discharge_Date)
AND YEAR(Date_of_Admission) = YEAR(Discharge_Date);
-- There are no patients who were admitted and discharged in same month.

-- 5. List all doctors who have treated more than 10 patients.
SELECT Doctor, COUNT(*) AS Treated_Patients FROM healthcare_dataset
GROUP BY Doctor HAVING COUNT(*) > 10;

-- 6. Find the average length of stay for patients in each room.
SELECT Room_Number, AVG(DATEDIFF(Discharge_Date, Date_of_Admission)) AS Avg_Length_of_Stay
FROM healthcare_dataset 
GROUP BY Room_Number;

-- 7. Retrieve patients who have not been discharged yet.
SELECT Name, Date_of_Admission, Doctor, Discharge_Date
FROM healthcare_dataset
WHERE Discharge_Date = '';

-- 8. Count the number of patients admitted under each insurance provider.
SELECT Insurance_Provider, COUNT(Name) AS Number_of_Patients from healthcare_dataset
GROUP BY Insurance_Provider;

-- 9. Find the total billing amount for each admission type (e.g., emergency, routine).
SELECT Admission_Type, SUM(Billing_Amount) AS Total_Billing_Amount FROM healthcare_dataset
GROUP BY Admission_Type;

-- 10. List all medications prescribed for patients with a specific medical condition (e.g., 'Flu')
SELECT DISTINCT Medication
FROM healthcare_dataset
WHERE Medical_Condition = 'Hypertension';

-- 11. Find the room number with the highest average billing amount.
SELECT Hospital, COUNT(*) AS hi FROM healthcare_dataset GROUP BY Hospital 
order by hi desc;

-- 12. Retrieve patients with their corresponding doctor and medication, who were treated in a specific hospital (e.g., 'St. Mary's Hospital').
SELECT Name, Doctor, Medication FROM healthcare_dataset WHERE Hospital = 'LLC Smith';

-- 13. Find the patients admitted on a specific date (e.g., '2025-01-01').
SELECT Name, Date_of_Admission, Medication FROM healthcare_dataset WHERE Date_of_Admission = '2/2/2024';