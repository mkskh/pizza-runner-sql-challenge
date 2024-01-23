-- D. Pricing and Ratings

-- 1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 
--and there were no charges for changes - how much money has Pizza Runner 
--made so far if there are no delivery fees?
/*

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
*/
	
-- 2. What if there was an additional $1 charge for any pizza extras?

/*SELECT 
	co.extras,
	((COUNT(CASE WHEN co.pizza_id = 1 THEN 1 END) * 12) 
	+ (COUNT(CASE WHEN co.pizza_id = 2 THEN 1 END) * 10) ) 
	+ (CASE WHEN ARRAY_LENGTH(co.extras, 1) = 2 THEN 2 
	ELSE ARRAY_LENGTH(co.extras, 1) * 1 END) AS "Total income"
FROM 	
	customer_orders co
JOIN
	runner_orders ro 
	ON ro.order_id = co.order_id 	
WHERE 
	ro.cancellation IS NULL
ORDER BY 
	co.extras;*/



/*SELECT 
    SUM(CASE 
            WHEN co.pizza_id = 1 THEN 12
            WHEN co.pizza_id = 2 THEN 10
            ELSE 0 
        END
        + (COALESCE(ARRAY_LENGTH(co.extras, 1), 0) * 1)
        + (CASE WHEN ARRAY_LENGTH(co.extras, 1) = 2 THEN 2 ELSE 0 END)
    ) AS "Total income"
FROM 
    customer_orders co
JOIN
    runner_orders ro ON ro.order_id = co.order_id
WHERE 
    ro.cancellation IS NULL;*/

	



