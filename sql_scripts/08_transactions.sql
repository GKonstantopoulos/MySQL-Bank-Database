USE GlobalBank_db;

-- TRANSACTION MANAGEMENT

START TRANSACTION;

UPDATE tbl_account 
SET acc_balance = acc_balance - 100.00 
WHERE acc_id = 1;
UPDATE tbl_cust_account 
SET ca_last_transaction_date = CURDATE() 
WHERE ca_acc_id = 1;

COMMIT;
