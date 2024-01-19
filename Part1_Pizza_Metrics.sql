--A. Pizza Metrics

--1. How many pizzas were ordered?

/*SELECT COUNT(order_id) AS "Total_orders"
FROM customer_orders ;*/

--2. How many unique customer orders were made?

/*SELECT COUNT(DISTINCT order_id) AS "Unique customer orders were made"
FROM customer_orders;*/

--3. How many successful orders were delivered by each runner?

/*SELECT 
	runners.runner_id,
	COUNT(runner_orders.order_id) AS "Successful orders were delivered"
FROM 
	runners,
	runner_orders
WHERE 
	runners.runner_id = runner_orders.runner_id
	AND runner_orders.cancellation IS NULL
GROUP BY 
	runners.runner_id
ORDER BY
	"Successful orders were delivered" DESC;*/


--4. How many of each type of pizza was delivered?

/*SELECT 
	pn.pizza_name,
	COUNT(co.pizza_id) AS "Successfully Delivered"
FROM 
	customer_orders co 
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id 
JOIN runner_orders ro ON ro.order_id = co.order_id 
WHERE ro.cancellation IS NULL
GROUP BY 
	pn.pizza_name;*/



--5. How many Vegetarian and Meatlovers were ordered by each customer?

/*SELECT 
	co.customer_id AS "Customer",
	COUNT(CASE WHEN co.pizza_id = 1 THEN 1 END) AS "Meatlovers",
	COUNT(CASE WHEN co.pizza_id = 2 THEN 1 END) AS "Vegetarian"
FROM 
	customer_orders co 
GROUP BY 
	co.customer_id
ORDER BY 
	co.customer_id;*/


--6. What was the maximum number of pizzas delivered in a single order?

/*
SELECT 
	co.order_id AS "ORDER number:",
	COUNT(co.order_id) AS "Number of pizzas delivered in a single order"
FROM 
	customer_orders co 
JOIN runner_orders ro ON ro.order_id = co.order_id 
WHERE ro.cancellation IS NULL
GROUP BY 
	"ORDER number:"
ORDER BY 
	"Number of pizzas delivered in a single order" DESC
	LIMIT 1;
*/

--7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

/*SELECT 
	co.customer_id AS "Customer",
	COUNT(DISTINCT CASE WHEN co.exclusions IS NOT NULL
	OR co.extras IS NOT NULL THEN co.order_id END) AS "Pizza with changes",
	COUNT(DISTINCT CASE WHEN co.exclusions IS NULL
	AND co.extras IS NULL THEN co.order_id END) AS "Pizza without changes"
FROM 
	customer_orders co
GROUP BY
	"Customer";*/


--8. How many pizzas were delivered that had both exclusions and extras?

/*SELECT 
	pn.pizza_name AS "Pizza Name:",
	COUNT(DISTINCT CASE WHEN co.exclusions IS NOT NULL
	AND co.extras IS NOT NULL THEN co.order_id END) 
	AS "Delivered quantity(total) with exclusions and extras"
FROM 
	customer_orders co
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id
JOIN runner_orders ro ON ro.order_id = co.order_id 
WHERE ro.cancellation IS NULL --order number 6 is not delivered(only ordered)
GROUP BY
	pn.pizza_name;*/

--9. What was the total volume of pizzas ordered for each hour of the day?

/*SELECT 	
	--
	--LPAD(EXTRACT(DAY FROM co.order_time)::TEXT, 2, '0') || '-' || 
	--LPAD(EXTRACT(MONTH FROM co.order_time)::TEXT, 2, '0')  AS "Date",
	--
	TO_CHAR(co.order_time, 'DD FMMonth') AS "Date",
	EXTRACT(HOUR FROM co.order_time) AS "Hour",
	COUNT(co.pizza_id) AS "Total volume of pizzas ordered"
FROM 
	customer_orders co
GROUP BY
	--
	--EXTRACT(DAY FROM co.order_time),
	--EXTRACT(MONTH FROM co.order_time),
	--
	TO_CHAR(co.order_time, 'DD FMMonth'),
	EXTRACT(HOUR FROM co.order_time)
ORDER BY
	"Date";*/

--10. What was the volume of orders for each day of the week?

SELECT 	
	--
	--LPAD(EXTRACT(DAY FROM co.order_time)::TEXT, 2, '0') || '-' || 
	--LPAD(EXTRACT(MONTH FROM co.order_time)::TEXT, 2, '0')  AS "Date",
	--
	TO_CHAR(co.order_time, 'DD FMMonth') AS "Date",
	COUNT(co.pizza_id) AS "Total volume of pizzas ordered"
FROM 
	customer_orders co
GROUP BY
	--
	--EXTRACT(DAY FROM co.order_time),
	--EXTRACT(MONTH FROM co.order_time),
	--
	TO_CHAR(co.order_time, 'DD FMMonth')
ORDER BY
	"Date";

