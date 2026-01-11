USE GlobalBank_db;

-- DATABASE VIEWS

CREATE  VIEW v_customer_overview AS
SELECT 
    c.cust_id,
    CONCAT(c.cust_name, ' ', c.cust_surname) AS full_name,
    ci.cy_name AS city,
    a.acc_acc_number AS account_no,
    a.acc_balance AS current_balance
FROM tbl_customer c
LEFT JOIN tbl_city ci ON c.cust_city = ci.cy_id
LEFT JOIN tbl_cust_account ca ON c.cust_id = ca.ca_cust_id
LEFT JOIN tbl_account a ON ca.ca_acc_id = a.acc_id;





