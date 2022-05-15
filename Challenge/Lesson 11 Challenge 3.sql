SELECT cust_email
FROM Customers
WHERE cust_id in (SELECT cust_id
				  FROM Orders
				  WHERE order_num in(SELECT order_num
								     FROM OrderItems
								     WHERE prod_id = 'BR01'));