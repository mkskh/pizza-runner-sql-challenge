-- 1. What are the standard ingredients for each pizza?

/*SELECT 
	pn.pizza_name,
	ARRAY_AGG(pt.topping_name) AS "Ingridients"
FROM
	pizza_names pn 
JOIN 
	pizza_recipes pr 
	ON pn.pizza_id = pr.pizza_id 
JOIN 
	pizza_toppings pt 
	ON pt.topping_id = ANY(string_to_array(pr.toppings, ', ')::INT[])

GROUP BY
    pn.pizza_name
ORDER BY
    pn.pizza_name;*/


--2. What was the most commonly added extra?

/*SELECT
	unnest("extras") AS "Ingrdient",
	COUNT(*) AS "Quantity of occurrence"
FROM
	customer_orders
WHERE 
	extras IS NOT NULL
GROUP BY 
	"Ingrdient"
ORDER BY 
	"Quantity of occurrence" DESC;*/


-- 3. What was the most common exclusion?

/*
SELECT
	unnest(exclusions) AS "Ingrdient",
	COUNT(*) AS "Quantity of occurrence"
FROM
	customer_orders
WHERE 
	exclusions IS NOT NULL
GROUP BY 
	"Ingrdient"
ORDER BY 
	"Quantity of occurrence" DESC;
*/


-- 4. Generate an order item for each record in the customers_orders table 
/*

SELECT 
	co.order_id,
	pn.pizza_name || 
	CASE 
		WHEN co.exclusions IS NOT NULL 
		THEN ' - Exclude ' || ARRAY_TO_STRING(ARRAY(SELECT pt.topping_name FROM pizza_toppings pt WHERE pt.topping_id = ANY(co.exclusions)), ', ')
		ELSE ''
	END ||
	CASE
		WHEN co.extras IS NOT NULL 
		THEN ' - Extra ' || ARRAY_TO_STRING(ARRAY(SELECT pt.topping_name FROM pizza_toppings pt WHERE pt.topping_id = ANY(co.extras)), ', ')
		ELSE ''
	END AS "Order Item"
FROM
	customer_orders co 
JOIN 
	pizza_names pn 
	ON pn.pizza_id = co.pizza_id;
*/
















