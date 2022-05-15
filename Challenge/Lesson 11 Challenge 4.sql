SELECT cust_id,
	   (SELECT SUM(item_price * quantity)
	    FROM OrderItems
	    WHERE OrderItems.order_num = Orders.order_num) AS total_ordered
FROM Orders
ORDER BY total_ordered DESC;