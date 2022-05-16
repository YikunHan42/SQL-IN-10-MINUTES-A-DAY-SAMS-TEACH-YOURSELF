-- 等联结
SELECT cust_name
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
AND Orders.order_num = OrderItems.order_num
GROUP BY cust_name HAVING SUM(item_price * quantity) >= 1000
ORDER BY cust_name;
-- Inner Join
SELECT cust_name
FROM Customers
INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
INNER JOIN OrderItems ON Orders.order_num = OrderItems.order_num
GROUP BY cust_name HAVING SUM(item_price * quantity) >= 1000
ORDER BY cust_name;