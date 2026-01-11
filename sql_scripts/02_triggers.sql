USE GlobalBank_db;

-- TRIGGER FOR TRANSACTION VALIDATION

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

