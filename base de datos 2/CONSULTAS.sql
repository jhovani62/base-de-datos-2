-1
SELECT p.id, p.name_promotion, p.description, p.amount, 
       p.start_date, p.end_date, p.discount_percentage
FROM store.promotion p
JOIN store.item i ON p.id_item = i.id
WHERE i.id = 10 AND p.is_active = TRUE;

-2
SELECT s.id, s.date_sale, s.total, u.user_name, 
       COALESCE(c.name_customer, 'Cliente no registrado') AS customer_name
FROM sale.sale s
JOIN usuari.user u ON s.id_user = u.id
LEFT JOIN sale.customer c ON s.id_customer = c.id
WHERE s.id_user = 7;  -- Usa un ID de usuario existente

-3
SELECT e.id, e.name_employee, p.name_post, p.description AS position_description
FROM employee.employee e
JOIN employee.contract c ON e.id = c.id_employee
JOIN employee.post p ON c.id_post = p.id
WHERE p.name_post = 'Gerente de Ventas';

-4
SELECT DISTINCT e.id, e.name_employee, p.name_post, 
       COUNT(s.id) AS sales_count, SUM(s.total) AS total_sales
FROM employee.employee e
JOIN usuari.user u ON e.id_user = u.id
JOIN sale.sale s ON u.id = s.id_user
JOIN employee.contract c ON e.id = c.id_employee
JOIN employee.post p ON c.id_post = p.id
GROUP BY e.id, e.name_employee, p.name_post
ORDER BY total_sales DESC;
-5
SELECT i.id, i.name_item, i.stock AS current_stock,
       (SELECT SUM(quantity) FROM buy.detail_buy WHERE id_item = i.id) AS total_purchased,
       (SELECT SUM(quantity) FROM sale.sale_detail WHERE id_item = i.id) AS total_sold,
       ((SELECT SUM(quantity) FROM buy.detail_buy WHERE id_item = i.id) - 
        (SELECT SUM(quantity) FROM sale.sale_detail WHERE id_item = i.id)) AS calculated_stock
FROM store.item i
WHERE i.id = 5;
-6
SELECT DISTINCT p.id, p.name_provider, p.phone, p.email
FROM buy.provider p
JOIN buy.buy b ON p.id = b.id_provider
JOIN buy.detail_buy db ON b.id_detail_buy = db.id
WHERE db.id_item = 2;
-7
SELECT EXTRACT(MONTH FROM date_sale) AS month_number,
       TO_CHAR(date_sale, 'Month') AS month_name,
       COUNT(*) AS total_sales,
       SUM(total) AS total_income
FROM sale.sale
WHERE EXTRACT(MONTH FROM date_sale) = 3  -- Cambiar por el número de mes deseado (1-12)
GROUP BY month_number, month_name;
-8
SELECT i.id, i.name_item, SUM(sd.quantity) AS total_sold
FROM sale.sale_detail sd
JOIN store.item i ON sd.id_item = i.id
GROUP BY i.id, i.name_item
ORDER BY total_sold DESC
LIMIT 1;
-9
SELECT c.id, c.name_customer, SUM(sd.quantity) AS total_items_purchased
FROM sale.customer c
JOIN sale.sale s ON c.id = s.id_customer
JOIN sale.sale_detail sd ON s.id_sale_detail = sd.id
GROUP BY c.id, c.name_customer
ORDER BY total_items_purchased DESC
LIMIT 1;
-10
SELECT c.id, c.name_customer, SUM(s.total) AS total_spent
FROM sale.customer c
JOIN sale.sale s ON c.id = s.id_customer
GROUP BY c.id, c.name_customer
ORDER BY total_spent DESC
LIMIT 1;
-11
SELECT COUNT(*) AS total_customers
FROM sale.customer;
-12
SELECT id, name_item, stock
FROM store.item
WHERE stock < 10
ORDER BY stock ASC;
-13
SELECT s.id AS sale_id, s.date_sale, c.name_customer, 
       i.name_item, sd.quantity, sd.price, sd.discount,
       (sd.price * sd.quantity * (1 - COALESCE(sd.discount, 0)/100) AS subtotal,
       s.total AS total_sale, u.user_name AS seller_username
FROM sale.sale s
JOIN sale.customer c ON s.id_customer = c.id
JOIN sale.sale_detail sd ON s.id_sale_detail = sd.id
JOIN store.item i ON sd.id_item = i.id
JOIN usuari.user u ON s.id_user = u.id
ORDER BY s.date_sale DESC;
-14
SELECT i.id, i.name_item, 
       SUM(db.quantity) AS total_purchased,
       SUM(sd.quantity) AS total_sold,
       i.stock AS current_stock,
       (SUM(db.quantity) - SUM(sd.quantity)) AS calculated_stock
FROM store.item i
LEFT JOIN buy.detail_buy db ON i.id = db.id_item
LEFT JOIN sale.sale_detail sd ON i.id = sd.id_item
GROUP BY i.id, i.name_item, i.stock
ORDER BY calculated_stock ASC;
-- Verificar datos en tablas clave
SELECT COUNT(*) FROM store.promotion;
SELECT COUNT(*) FROM store.item;
SELECT COUNT(*) FROM sale.sale;
SELECT COUNT(*) FROM sale.customer;
SELECT COUNT(*) FROM employee.employee;
SELECT COUNT(*) FROM employee.post;
SELECT COUNT(*) FROM buy.provider;
SELECT COUNT(*) FROM buy.detail_buy;
select *from sale.customer