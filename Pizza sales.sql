--Pizzas sales SQL QUERIES


CREATE TABLE pizzas(
					pizza_id VARCHAR(200) PRIMARY KEY, 
					order_id  VARCHAR(200),
					pizza_name_id  VARCHAR(200),
					quantity  VARCHAR(100),
					order_date VARCHAR(200),
					order_time  VARCHAR(200),
					unit_price FLOAT,
					total_price	FLOAT,
					pizza_size VARCHAR(50),
					pizza_category  VARCHAR(100),
					pizza_ingredients  VARCHAR(300),
					pizza_name VARCHAR(200)
);

--To Check the Table
SELECT * FROM pizzas;


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
--Hourly Trend
--Both EXTRACT and DATE_PART functions achieve the same result,
--so you can use either of them based on your preference or specific requirements.

SELECT * FROM pizzas;

ALTER TABLE pizzas
ALTER order_time SET DATA TYPE TIME
USING order_time::TIME;

SELECT EXTRACT(HOUR FROM order_time) AS Order_hours,
COUNT(DISTINCT order_id) AS total_orders
FROM pizzas
GROUP BY EXTRACT(HOUR FROM order_time) 
ORDER BY EXTRACT(HOUR FROM order_time);


--%age of sales by pizza category

SELECT pizza_category AS pizza_category, 
SUM(total_price) * 100/ (SELECT SUM(total_price) FROM pizzas) AS PCT
FROM pizzas
GROUP BY pizza_category
ORDER BY SUM(total_price) * 100/ (SELECT SUM(total_price) FROM pizzas) DESC;


SELECT pizza_category AS pizza_category, 
SUM(total_price) * 100/ (SELECT SUM(total_price) FROM pizzas WHERE EXTRACT(MONTH FROM order_date) = 1 ) AS PCT
FROM pizzas
WHERE EXTRACT(MONTH FROM order_date) = 1
GROUP BY pizza_category
ORDER BY SUM(total_price) * 100/ (SELECT SUM(total_price) FROM pizzas) DESC;

--%age by pizza size

SELECT pizza_size AS pizza_size,
CAST(SUM(total_price) * 100/ (SELECT SUM(total_price) FROM pizzas) AS DECIMAL(10,2)) AS PST
FROM pizzas
GROUP BY pizza_size
ORDER BY PST DESC;

SELECT pizza_size AS pizza_size,
CAST(SUM(total_price) * 100/ (SELECT SUM(total_price) 
	FROM pizzas WHERE EXTRACT(QUARTER FROM order_date) = 1) AS DECIMAL(10,2)) AS PST
FROM pizzas
WHERE EXTRACT(QUARTER FROM order_date) = 1
GROUP BY pizza_size
ORDER BY PST DESC;

--Total Pizzas Sold By Pizza Category

SELECT pizza_category, SUM(quantity) AS total_pizzas_sold
FROM pizzas
GROUP BY pizza_category
ORDER BY total_pizzas_sold DESC;

-- Top 5 best sellers by total pizzas sold

SELECT pizza_name, SUM(quantity) AS total_sales
FROM pizzas
GROUP BY pizza_name
ORDER BY total_sales DESC 
LIMIT 5;

-- Bottom 5 Worst sellers by total pizzas sold

SELECT pizza_name, SUM(quantity) AS total_sales
FROM pizzas
GROUP BY pizza_name
ORDER BY total_sales ASC
LIMIT 5;