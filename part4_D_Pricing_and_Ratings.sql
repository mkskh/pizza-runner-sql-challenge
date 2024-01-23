-- D. Pricing and Ratings

-- 1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 
--and there were no charges for changes - how much money has Pizza Runner 
--made so far if there are no delivery fees?


SELECT 
	((COUNT(CASE WHEN co.pizza_id = 1 THEN 1 END) * 12) 
	+ (COUNT(CASE WHEN co.pizza_id = 2 THEN 1 END) * 10) ) AS "Total income"
FROM 	
	customer_orders co
JOIN
	runner_orders ro 
	ON ro.order_id = co.order_id 
WHERE 
	ro.cancellation IS NULL;

