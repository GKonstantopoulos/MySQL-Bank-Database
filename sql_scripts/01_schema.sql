/* BANKING SYSTEM DATABASE PROJECT
Target Database: MySQL
Implementation: Portfolio Final Version
*/

DROP DATABASE IF EXISTS GlobalBank_db;
CREATE DATABASE IF NOT EXISTS GlobalBank_db;
USE GlobalBank_db;

ALTER DATABASE GlobalBank_db CHARACTER SET = utf8mb4;


-- 1. LOOKUP TABLES

CREATE TABLE tbl_city(
    cy_id INT AUTO_INCREMENT PRIMARY KEY,
    cy_name VARCHAR(30) NOT NULL
);

CREATE TABLE tbl_branch_type(
    brt_id INT AUTO_INCREMENT PRIMARY KEY,
    brt_type VARCHAR(15) NOT NULL
);

CREATE TABLE tbl_empl_type(
    emplt_id TINYINT AUTO_INCREMENT PRIMARY KEY,
    emplt_type VARCHAR(20) NOT NULL
);

CREATE TABLE tbl_tr_type(
    trt_id INT AUTO_INCREMENT PRIMARY KEY,
    trt_type VARCHAR(20) NOT NULL
);


-- 2. CORE ENTITIES

CREATE TABLE tbl_bank (
    bank_code INT AUTO_INCREMENT PRIMARY KEY,
    bank_title VARCHAR(30) NOT NULL,
    bank_type VARCHAR(30) NOT NULL,
    bank_head_office INT,
    FOREIGN KEY (bank_head_office) REFERENCES tbl_city(cy_id) ON DELETE SET NULL
);

CREATE TABLE tbl_branch (
    br_id INT AUTO_INCREMENT PRIMARY KEY,
    br_type INT,
    br_addr VARCHAR(40) NOT NULL,
    br_city INT,
    br_bank_code INT,
    FOREIGN KEY (br_bank_code) REFERENCES tbl_bank (bank_code) ON DELETE SET NULL,
    FOREIGN KEY (br_type) REFERENCES tbl_branch_type (brt_id) ON DELETE SET NULL,
    FOREIGN KEY (br_city) REFERENCES tbl_city (cy_id) ON DELETE SET NULL
);

CREATE TABLE tbl_customer (
    cust_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_surname VARCHAR(30) NOT NULL,
    cust_name VARCHAR(30) NOT NULL,
    cust_birth_date DATE NOT NULL,
    cust_tax_no CHAR(20) NOT NULL UNIQUE, 
    cust_address VARCHAR(50) NOT NULL,
    cust_post_code VARCHAR(10) NOT NULL,
    cust_city INT,
    FOREIGN KEY (cust_city) REFERENCES tbl_city (cy_id) ON DELETE SET NULL
);

CREATE TABLE tbl_employee(
    empl_id INT AUTO_INCREMENT PRIMARY KEY,
    empl_surname VARCHAR(30) NOT NULL,
    empl_name VARCHAR(30) NOT NULL,
    empl_type TINYINT,
    empl_salary DECIMAL(10,2) NOT NULL,
    empl_cust_id INT DEFAULT NULL,
    empl_br_id INT,
    FOREIGN KEY (empl_br_id) REFERENCES tbl_branch (br_id) ON DELETE SET NULL,
    FOREIGN KEY (empl_type) REFERENCES tbl_empl_type (emplt_id) ON DELETE SET NULL,
    FOREIGN KEY (empl_cust_id) REFERENCES tbl_customer (cust_id) ON DELETE SET NULL
);

CREATE TABLE tbl_account (
    acc_id INT AUTO_INCREMENT PRIMARY KEY,
    acc_acc_number CHAR(25) NOT NULL UNIQUE,
    acc_balance DECIMAL(15,2) NOT NULL,
    acc_overdraft DECIMAL(10,2) NOT NULL 
);

CREATE TABLE tbl_cust_account (
    ca_id INT AUTO_INCREMENT PRIMARY KEY,
    ca_acc_id INT,
    ca_cust_id INT,
    ca_last_transaction_date DATE NOT NULL,
    ca_last_transaction_type INT,
    ca_last_transaction_amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT amount_check1 CHECK (ca_last_transaction_amount > 0.0),
    FOREIGN KEY (ca_acc_id) REFERENCES tbl_account (acc_id) ON DELETE CASCADE,
    FOREIGN KEY (ca_cust_id) REFERENCES tbl_customer (cust_id) ON DELETE CASCADE,
    FOREIGN KEY (ca_last_transaction_type) REFERENCES tbl_tr_type (trt_id) ON DELETE SET NULL
);

CREATE TABLE tbl_credit_card(
    cc_id INT AUTO_INCREMENT PRIMARY KEY,
    cc_pan CHAR(20) NOT NULL UNIQUE,          
    cc_balance DECIMAL(12,2) NOT NULL,        
    cc_credit_limit DECIMAL(10,2) NOT NULL,   
    cc_cash_limit DECIMAL(10,2) NOT NULL,     
    cc_cust_id INT,
    FOREIGN KEY (cc_cust_id) REFERENCES tbl_customer (cust_id) ON DELETE SET NULL
);

CREATE TABLE tbl_cc_transaction(
    ct_id INT AUTO_INCREMENT PRIMARY KEY,
    ct_cc_id INT,
    ct_last_transaction_date DATE NOT NULL,
    ct_last_transaction_type INT,
    ct_last_transaction_amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT amount_check CHECK (ct_last_transaction_amount > 0.0),
    FOREIGN KEY (ct_cc_id) REFERENCES tbl_credit_card (cc_id) ON DELETE CASCADE,
    FOREIGN KEY (ct_last_transaction_type) REFERENCES tbl_tr_type (trt_id) ON DELETE SET NULL
);


-- 3. TRIGGER FOR TRANSACTION VALIDATION

DELIMITER //
CREATE TRIGGER trg_cc_transaction_before_insert
BEFORE INSERT ON tbl_cc_transaction
FOR EACH ROW
BEGIN
    DECLARE current_balance DECIMAL(12,2);
    
    SELECT cc_balance INTO current_balance 
    FROM tbl_credit_card 
    WHERE cc_id = NEW.ct_cc_id;

    IF NEW.ct_last_transaction_amount > current_balance THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction Denied: Insufficient credit balance!';
    ELSE
        UPDATE tbl_credit_card 
        SET cc_balance = cc_balance - NEW.ct_last_transaction_amount
        WHERE cc_id = NEW.ct_cc_id;
    END IF;
END;
//
DELIMITER ;


-- 4. DATA INSERTION

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
