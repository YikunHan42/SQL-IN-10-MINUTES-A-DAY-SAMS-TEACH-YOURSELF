SELECT SUM(quantity) AS total_BR01_product
FROM OrderItems
WHERE prod_id = 'BR01';