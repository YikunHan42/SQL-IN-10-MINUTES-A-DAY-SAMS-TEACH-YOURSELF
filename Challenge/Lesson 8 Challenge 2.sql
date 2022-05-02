SELECT order_num, order_date
FROM ORDERS
WHERE YEAR(order_date) = 2020 AND MONTH(order_date) = 1
ORDER BY order_date;