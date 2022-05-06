SELECT vend_id, MIN(prod_price) AS cheapest_item
FROM Products
GROUP BY prod_id
ORDER BY cheapest_item;