USE GlobalBank_db;

-- ANALYTICAL QUERIES

-- Q1: Customer Segmentation based on Balance
SELECT 
    cust_surname, 
    acc_balance,
    CASE 
        WHEN acc_balance > 50000 THEN 'VIP'
        WHEN acc_balance BETWEEN 10000 AND 50000 THEN 'Premium'
        ELSE 'Standard'
    END AS customer_tier
FROM tbl_customer c
JOIN tbl_cust_account ca ON c.cust_id = ca.ca_cust_id
JOIN tbl_account a ON ca.ca_acc_id = a.acc_id;

-- Q2: Marketing Insights - Customers without Credit Cards
SELECT 
	c.cust_id, 
	c.cust_surname, 
	c.cust_name 
FROM tbl_customer c 
WHERE c.cust_id NOT IN ( 
    SELECT cc_cust_id 
    FROM tbl_credit_card 
    WHERE cc_cust_id IS NOT NULL 
);

-- Q3: Total Assets per City
SELECT 
    ci.cy_name, 
    COUNT(c.cust_id) AS total_customers, 
    SUM(a.acc_balance) AS total_deposits
FROM tbl_city ci
LEFT JOIN tbl_customer c ON ci.cy_id = c.cust_city
LEFT JOIN tbl_cust_account ca ON c.cust_id = ca.ca_cust_id
LEFT JOIN tbl_account a ON ca.ca_acc_id = a.acc_id
GROUP BY ci.cy_name;

--  Q4: Customer with the largest balance
SELECT 
    c.cust_id,
    c.cust_name,
    c.cust_surname,
    a.acc_acc_number,
    a.acc_balance
FROM tbl_customer c
JOIN tbl_cust_account ca ON c.cust_id = ca.ca_cust_id
JOIN tbl_account a ON ca.ca_acc_id = a.acc_id
ORDER BY a.acc_balance DESC
LIMIT 1;

