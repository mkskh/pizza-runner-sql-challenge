DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  "runner_id" SERIAL PRIMARY KEY,
  "registration_date" DATE
);
INSERT INTO runners
  ("runner_id", "registration_date")
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  "pizza_id" SERIAL PRIMARY KEY,
  "pizza_name" TEXT
);
INSERT INTO pizza_names
  ("pizza_id", "pizza_name")
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  "pizza_id" INT REFERENCES pizza_names(pizza_id),
  "toppings" INT[]
);
INSERT INTO pizza_recipes
  ("pizza_id", "toppings")
VALUES
  (1, ARRAY[1, 2, 3, 4, 5, 6, 8, 10]),
  (2, ARRAY[4, 6, 7, 9, 11, 12]);


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  "topping_id" SERIAL PRIMARY KEY,
  "topping_name" TEXT
);
INSERT INTO pizza_toppings
  ("topping_id", "topping_name")
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  "order_id" SERIAL PRIMARY KEY,
  "runner_id" INT REFERENCES runners(runner_id),
  "pickup_time" TIMESTAMP,
  "distance" NUMERIC,
  "duration" INTEGER,
  "cancellation" VARCHAR(23)
);

INSERT INTO runner_orders
  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation")
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20', '32', NULL),
  ('2', '1', '2020-01-01 19:10:54', '20', '27', NULL),
  ('3', '1', '2020-01-03 00:12:37', '13.4', '20', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', NULL, NULL, NULL, 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25', '25', NULL),
  ('8', '2', '2020-01-10 00:15:02', '23.4', '15', NULL),
  ('9', '2', NULL, NULL, NULL, 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10', '10', NULL);
 
 
  DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  "order_id" INT REFERENCES runner_orders(order_id),
  "customer_id" INTEGER,
  "pizza_id" INT REFERENCES pizza_names(pizza_id),
  "exclusions" INT[],
  "extras" INT[],
  "order_time" TIMESTAMP
);

INSERT INTO customer_orders
  ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
VALUES
  ('1', '101', '1', NULL, NULL, '2020-01-01 18:05:02'),
  ('2', '101', '1', NULL, NULL, '2020-01-01 19:00:52'),
  ('3', '102', '1', NULL, NULL, '2020-01-02 23:51:23'),
  ('3', '102', '2', NULL, NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', ARRAY[4], NULL, '2020-01-04 13:23:46'),
  ('4', '103', '1', ARRAY[4], NULL, '2020-01-04 13:23:46'),
  ('4', '103', '2', ARRAY[4], NULL, '2020-01-04 13:23:46'),
  ('5', '104', '1', NULL, ARRAY[1], '2020-01-08 21:00:29'),
  ('6', '101', '2', NULL, NULL, '2020-01-08 21:03:13'),
  ('7', '105', '2', NULL, ARRAY[1], '2020-01-08 21:20:29'),
  ('8', '102', '1', NULL, NULL, '2020-01-09 23:54:33'),
  ('9', '103', '1', ARRAY[4], ARRAY[1, 5], '2020-01-10 11:22:59'),
  ('10', '104', '1', NULL, NULL, '2020-01-11 18:34:49'),
  ('10', '104', '1', ARRAY[2, 6], ARRAY[1, 4], '2020-01-11 18:34:49');
 
 
 
 