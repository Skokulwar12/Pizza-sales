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