SELECT cust_id,
	   cust_name,
	   CONCAT(UPPER(LEFT(cust_contact, 2), LEFT(cust_city, 3))) AS user_login
FROM Customers;