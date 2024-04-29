--Total Revenue

SELECT SUM(total_price) AS total_revenue
FROM pizzas;

--Average Order Value
SELECT SUM(total_price)/ COUNT(DISTINCT order_id) 
AS Average_order_value
FROM pizzas;

--ALTERING DATA TYPE
ALTER TABLE pizzas
ALTER COLUMN quantity TYPE INTEGER
USING quantity::INTEGER;

--Total Pizzas sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizzas;

--Total Orders
SELECT COUNT (DISTINCT order_id)
FROM pizzas;

--Avg pizzas per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))
			/CAST(COUNT (DISTINCT order_id) AS DECIMAL(10,3)) AS DECIMAL (10,2))
AS Avg_pizzas_per_order
FROM pizzas;

--Creating Charts

ALTER TABLE pizzas
ALTER COLUMN order_date TYPE DATE
USING order_date::DATE;

--Orders (Daily_trend)

SELECT TO_CHAR(order_date, 'Day') AS day_of_week,
COUNT (DISTINCT order_id) AS total_orders
FROM pizzas
GROUP BY TO_CHAR(order_date, 'Day')
ORDER BY COUNT (DISTINCT order_id);

--
