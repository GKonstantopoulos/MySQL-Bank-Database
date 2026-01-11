USE GlobalBank_db;

-- STORED PROCEDURES

DELIMITER //
CREATE PROCEDURE sp_get_customers_by_city(IN city_name_param VARCHAR(30))
BEGIN
    SELECT cust_id, cust_name, cust_surname, cust_address
    FROM tbl_customer c
    JOIN tbl_city ci ON c.cust_city = ci.cy_id
    WHERE ci.cy_name = city_name_param;
END //
DELIMITER ;
