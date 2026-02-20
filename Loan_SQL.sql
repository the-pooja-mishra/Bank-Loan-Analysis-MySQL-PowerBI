CREATE database Bank_loan_db;

Use bank_loan_db;
SELECT * FROM financial_loan;

SELECT count(id)  As total_applications FROM financial_loan;

SELECT issue_date
FROM financial_loan
LIMIT 10;

DESCRIBE financial_loan;

SELECT count(id)  As MTD_total_applications;
  
SELECT issue_date
FROM financial_loan
WHERE issue_date IS NOT NULL
LIMIT 10;

-- Month to date total loan applications

SELECT COUNT(id) AS MTD_total_applications
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
  AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- previous Month to date total loan applications
SELECT count(id) AS PMTD_laon_Applications
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11 
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Total funded amount
SELECT SUM(loan_amount) As Total_Funded_Amount
FROM financial_loan;

-- Month to date total funded amount
SELECT SUM(loan_amount) As MTD_Total_Funded_Amount
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- previous Month to date total

SELECT SUM(loan_amount) As PMTD_Total_Funded_Amount
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Total received amount
SELECT SUM(total_payment) AS Total_Amount_Received
FROM financial_loan;

-- Month to date total amount received
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Previous Month to date total amount received
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Average interest rate
SELECT Round(Avg(int_rate), 2)*100 AS Avg_Interest_Rate
FROM financial_loan;

-- Month to date total amount received
SELECT Avg(int_rate) *100 AS MTD_Avg_Interest_Rate
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Previous Month to date total amount received
SELECT Avg(int_rate) *100 AS PMTD_Avg_Interest_Rate
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Avg DTI
SELECT Round(AVG(dti), 4) *100 AS Avg_dti
FROM financial_loan;

-- Month to date Avg debt to income 

SELECT Round(AVG(dti), 4) *100 AS MTD_Avg_dti
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Previous Month to date Avg debt to income 
SELECT Round(AVG(dti), 4) *100 AS PMTD_Avg_dti
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 11
AND YEAR(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 2021;

-- Good loan application percentage

SELECT Count(id) AS Good_Loans_applications
FROM financial_loan
WHERE loan_status= 'Fully Paid' or loan_status= 'Current';

SELECT (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status= 'Current' THEN id END) *100)
/ COUNT(id) AS Good_loan_percentage
FROM financial_loan;

-- Good loan funded amount
SELECT * FROM financial_loan;

SELECT SUM(loan_amount) AS Good_Loans_Funded_amount
FROM financial_loan
WHERE loan_status= 'Fully Paid' or loan_status= 'Current';

-- Good loan received amount

SELECT SUM(total_payment) AS Good_Loans_received_amount
FROM financial_loan
WHERE loan_status= 'Fully Paid' or loan_status= 'Current';

-- Bad loan application percentage

SELECT Count(id) AS Bad_Loans_applications
FROM financial_loan
WHERE loan_status= 'Charged off';

SELECT (COUNT(CASE WHEN loan_status = 'Charged off' THEN id END) *100)
/ COUNT(id) AS Bad_loan_percentage
FROM financial_loan;

-- Bad loan application percentage

SELECT Count(id) AS Bad_Loans_applications
FROM financial_loan
WHERE loan_status= 'Charged off';

-- Bad loan funded amount

SELECT SUM(loan_amount) AS Bad_Loans_Funded_amount
FROM financial_loan
WHERE loan_status= 'Charged off';

-- -- Bad loan received amount

SELECT SUM(total_payment) AS Bad_Loans_received_amount
FROM financial_loan
WHERE loan_status= 'Charged off';

-- Loan Status

SELECT loan_status, count(id) AS Total_loan_Applications,
       SUM(total_payment) AS Total_Amount_Received,
       SUM(loan_amount) AS Tota_funded_amount,
       AVG(int_rate *100) As Avg_Interest_rate,
       Avg(dti *100) AS Avg_DTI
FROM financial_loan
GROUP BY loan_status;

-- Month to date funded and received amount 

SELECT loan_status,
       SUM(total_payment) AS MTD_Amount_Received,
       SUM(loan_amount) AS MTD_funded_amount
FROM financial_loan
WHERE MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) = 12
GROUP BY loan_status;


-- Monthly fund and received amount trend
-- STR_TO_DATE (use to convert TEXT to date)

SELECT 
    MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')) AS Month_number,
    MONTHNAME(STR_TO_DATE(issue_date, '%d-%m-%Y')) AS Month_Name,
    COUNT(id) AS Total_loan_Applications,
    SUM(total_payment) AS MTD_Amount_Received,
    SUM(loan_amount) AS MTD_funded_amount
FROM financial_loan
GROUP BY MONTH(STR_TO_DATE(issue_date, '%d-%m-%Y')),
         MONTHNAME(STR_TO_DATE(issue_date, '%d-%m-%Y'))
ORDER BY Month_number;

-- Regional Analysis by state

SELECT address_state,
    COUNT(id) AS Total_loan_Applications,
    SUM(total_payment) AS MTD_Amount_Received,
    SUM(loan_amount) AS MTD_funded_amount
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;

-- Long term Analysis

SELECT term,
           COUNT(id) AS Total_loan_Applications,
    SUM(total_payment) AS MTD_Amount_Received,
    SUM(loan_amount) AS MTD_funded_amount
FROM financial_loan
GROUP BY term
ORDER BY term;

-- Employee length Analysis

Select * FROM financial_loan;

SELECT emp_length,
           COUNT(id) AS Total_loan_Applications,
    SUM(total_payment) AS MTD_Amount_Received,
    SUM(loan_amount) AS MTD_funded_amount
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;

-- Loan purpose analysis

SELECT purpose,
           COUNT(id) AS Total_loan_Applications,
    SUM(total_payment) AS MTD_Amount_Received,
    SUM(loan_amount) AS MTD_funded_amount
FROM financial_loan
GROUP BY purpose
ORDER BY COUNT(id) DESC;

-- HOME Ownership analysis
SELECT home_ownership,
           COUNT(id) AS Total_loan_Applications,
    SUM(total_payment) AS MTD_Amount_Received,
    SUM(loan_amount) AS MTD_funded_amount
FROM financial_loan
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;
