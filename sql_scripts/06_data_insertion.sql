USE GlobalBank_db;

-- DATA INSERTION

INSERT INTO tbl_city (cy_name) VALUES ('Athens'), ('London'), ('Paris'), ('New York'), ('Thessaloniki');
INSERT INTO tbl_branch_type (brt_type) VALUES ('RETAIL'), ('CORPORATE'), ('GOLD'), ('PRIVATE'), ('DIGITAL');
INSERT INTO tbl_empl_type (emplt_type) VALUES ('Officer'), ('Senior Officer'), ('Executive'), ('Manager'), ('Clerk');
INSERT INTO tbl_tr_type (trt_type) VALUES ('Withdrawal'), ('Deposit'), ('Transfer'), ('Payment'), ('Purchase');

INSERT INTO tbl_bank (bank_title, bank_type, bank_head_office)
VALUES ('AW_Bank', 'Commercial', 1), ('CW_Finance', 'Investment', 2), ('GW_Insure', 'Insurance', 3), ('DW_Crypto', 'Digital', 4), ('EW_Private', 'Commercial', 5);

INSERT INTO tbl_branch (br_type, br_addr, br_city, br_bank_code) 
VALUES (1, 'Main St 10', 1, 1), (2, 'Wall Street 5', 4, 2), (3, 'Tsimiski 45', 5, 1), (4, 'Fleet St 101', 2, 2), (5, 'Rue de Rivoli 20', 3, 3);

INSERT INTO tbl_customer (cust_surname, cust_name, cust_birth_date, cust_tax_no, cust_address, cust_post_code, cust_city)
VALUES 
('Papadopoulos','Nikos','1985-01-15','TAX-101','Athinas 1', 'A00431', 1),
('Smith','Allan','1990-12-22','TAX-102','Oxford St 5', 'O12457', 2),
('Katikou','Maria','1975-06-11','TAX-103','Egnatia 22', 'E46283', 5),
('Nikolaou','Eirini','2001-01-14','TAX-104','Broadway 100', 'B0001', 4),
('Dupont','Jean','1968-09-23','TAX-105','Place de la Concorde', 'P5000', 3);

INSERT INTO tbl_employee (empl_surname, empl_name, empl_type, empl_salary, empl_cust_id, empl_br_id)
VALUES
('Karakostas','Nikos',2,1500.00,NULL,1), ('Miller','Alice',3,2800.00,NULL,2), ('Dimitriou','Eleni',1,1100.00,NULL,3), ('Papas','Georgios',4,3500.00,NULL,4), ('Karas','Ioannis',5,950.00,NULL,5);

INSERT INTO tbl_account(acc_acc_number, acc_balance, acc_overdraft)
VALUES ('IBAN-GR-001', 12000.00, 500.00), ('IBAN-UK-002', 450.50, 0.00), ('IBAN-FR-003', 8900.00, 1000.00), ('IBAN-US-004', 120.00, 50.00), ('IBAN-GR-005', 55430.00, 5000.00);

INSERT INTO tbl_cust_account(ca_acc_id, ca_cust_id, ca_last_transaction_date, ca_last_transaction_type, ca_last_transaction_amount)
VALUES (1, 1, '2023-10-01', 2, 500.00), (2, 2, '2023-10-05', 1, 20.00), (3, 5, '2023-11-12', 3, 1200.00), (4, 4, '2023-12-01', 5, 45.00), (5, 3, '2023-12-15', 2, 10000.00);

INSERT INTO tbl_credit_card(cc_pan, cc_balance, cc_credit_limit, cc_cash_limit, cc_cust_id)
VALUES ('4000-1111', 150.00, 2000.00, 500.00, 1), ('4000-2222', 450.00, 2000.00, 500.00, 2), ('4000-3333', 1000.00, 5000.00, 1000.00, 3), ('4000-4444', 1200.00, 1500.00, 200.00, 4); 

INSERT INTO tbl_cc_transaction(ct_cc_id, ct_last_transaction_date, ct_last_transaction_type, ct_last_transaction_amount)
VALUES (1, '2025-10-20', 5, 50.00), (2, '2025-10-21', 5, 12.50), (3, '2025-11-01', 4, 300.00), (4, '2024-11-05', 5, 85.00);
