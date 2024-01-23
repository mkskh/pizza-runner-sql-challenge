--B. Runner and Customer Experience

-- 1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

--
--Start from real start of the week
--
/*SELECT 
    DATE_TRUNC('week', registration_date) AS "Week",
    COUNT(runner_id) AS "Runners"
FROM 
    runners
GROUP BY 
    "Week"
ORDER BY 
    "Week";*/

   
-- 2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

/*
SELECT
	ro.runner_id AS "Runner:",
	AVG(EXTRACT(MINUTE FROM (ro.pickup_time - co.order_time))::INT) AS "Avarage time (min)"
FROM 
	runner_orders ro 
JOIN 
	customer_orders co 
	ON co.order_id = ro.order_id
WHERE 
	ro.cancellation IS NULL
GROUP BY 
	"Runner:";
	*/


-- 3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

/*

SELECT
	co.order_id,
	COUNT( co.order_id) AS "Quantity",
	AVG(EXTRACT(MINUTE FROM (ro.pickup_time - co.order_time))::INT) 
		AS "Avarage time for preparing (min)"
FROM 
	customer_orders co 
JOIN 
	runner_orders ro 
	ON co.order_id = ro.order_id
WHERE 
	ro.cancellation IS NULL
GROUP BY 
	co.order_id;
*/

-- ANSER - Yes, there is the relationship between the number of pizzas 
--and how long the order takes to prepare


-- 4. What was the average distance travelled for each customer?

/*

SELECT
	co.customer_id,
	AVG(DISTINCT ro.distance) AS "Avarage distance"
FROM 
	customer_orders co 
JOIN 
	runner_orders ro 
	ON co.order_id = ro.order_id
WHERE 
	ro.cancellation IS NULL
GROUP BY 
	co.customer_id;
*/


-- 5. What was the difference between the longest and shortest delivery times for all orders?

/*

SELECT
	(MAX(distance) - MIN(distance)) AS "DIFFERENCE"	
FROM 
	runner_orders ro 
WHERE 
	ro.cancellation IS NULL;
*/


-- 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

/*SELECT
	ro.runner_id,
	AVG(((60 / ro.duration) * ro.distance)) AS "Avarage speed"	
FROM 
	runner_orders ro 
WHERE 
	ro.cancellation IS NULL
GROUP BY
	ro.runner_id;*/

	
-- 7. What is the successful delivery percentage for each runner?

SELECT
	ro.runner_id,
	CONCAT((COUNT(CASE WHEN ro.cancellation  IS NULL THEN ro.runner_id END) 
	* 100 / COUNT(ro.runner_id)), '%') AS "Successful delivery percentage"	
FROM 
	runner_orders ro 
GROUP BY
	ro.runner_id;




