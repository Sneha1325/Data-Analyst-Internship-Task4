

SELECT * FROM Customers;

SELECT COUNT(*) AS total_customers FROM Customers;

SELECT *
FROM Orders
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT p.product_name,
       SUM(oi.quantity) AS total_sold
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 10;

SELECT SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM OrderItems oi;

SELECT c.category_name,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;

SELECT AVG(order_total) AS avg_order_value
FROM (
    SELECT o.order_id,
           SUM(oi.quantity * oi.unit_price) AS order_total
    FROM Orders o
    JOIN OrderItems oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
) AS t;

SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_orders DESC
LIMIT 5;

SELECT order_id,
       COUNT(*) AS items_in_order
FROM OrderItems
GROUP BY order_id
HAVING COUNT(*) > 1;


SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(o.order_id) AS orders_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING orders_count > 1;

CREATE VIEW product_sales_summary AS
SELECT p.product_id,
       p.product_name,
       SUM(oi.quantity) AS total_quantity_sold,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_id;

CREATE INDEX idx_product_id ON OrderItems(product_id);
