USE GlobalBank_db;

-- PERFORMANCE OPTIMIZATION (INDEXES)


CREATE INDEX idx_cust_surname ON tbl_customer(cust_surname);
CREATE INDEX idx_acc_number ON tbl_account(acc_acc_number);




