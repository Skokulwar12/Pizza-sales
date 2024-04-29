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

SELECT SUM(total_price) FROM pizzas AS total_revenue;