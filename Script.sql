-- 1. Inventory report: For each topping in the database, show the topping name, the current
-- inventory level and the number of X-large pizzas that could be made using that amount of the
-- topping. Order alphabetically by topping name

SELECT topping_name, current_inventory_level, (current_inventory_level / amount_used_xlarge) AS 'X-large pizzas that could be made'
FROM Toppings;


-- 3. Customer report: For each customer in the database, display their name, the total number of
-- orders they have placed, the average of the order price, the total order price, the max order
-- price, and the minimum order price. Dine in orders should not be included.

SELECT customer_fname AS "First Name", customer_lname AS 'Last Name', count(c.customer_id) AS 'Number of orders placed',
        AVG(total_price), SUM(total_price), MAX(total_price), MIN(total_price)
FROM Customer AS c join Orders AS o ON c.customer_id=o.customer_id
GROUP BY c.customer_id;

-- 5. Order ticket: On March 5th at 7:11 pm, Andrew Wilkes-Krier placed an order. The kitchen staff
-- needs to know what to prepare for the order. For each pizza on the order, display the crust, size,
-- a list of toppings, and whether or not they ordered extra of that topping. It is fine to have
-- repeated data about the pizza (such as crust size, type) in order to display all the toppings in the
-- table, however the information should be ordered by the pizzas so all the toppings for one pizza
-- appear in consecutive rows

SELECT order_id, p.pizza_id, crust_type, pizza_size, topping_name, amount
FROM (BasePrice AS bp join Pizza AS p ON bp.base_price_id=p.base_price_id) join ToppingsOnPizza AS tp ON p.pizza_id=tp.pizza_id
WHERE order_id IN (
    SELECT order_id
    FROM Orders 
    WHERE customer_id IN(
        select customer_id
        FROM Customer
        WHERE customer_fname='Andrew' AND customer_lname='Wilkes-Krier'
    )
    AND order_timestamp='2024-03-05 19:11'
);

--  7. Discount report: For each discount, display the discount name and the count of orders that used
-- that discount, and the total money saved by customers from using that discount.

SELECT discount_name AS "Discount", count(dp.discount_id) + count(do.discount_id) AS 'Times used',
 IFNULL(SUM(o.total_price * (d.percentage_off / 100)),0) + IFNULL(SUM(d.amount_off),0) AS 'total money saved'
FROM ((Discount AS d left join DiscountOnPizza AS dp ON d.discount_id=dp.discount_id) 
      left join DiscountOnOrder AS do ON d.discount_id=do.discount_id) left join Orders AS o ON o.order_id=do.order_id
GROUP BY d.discount_id;


-- 9. Pizza Size report: For each Pizza size, show the total number of pizzas ordered, average price,
-- and average cost of those pizzas.

--  SELECT bp.pizza_size, bp.price + (SUM(t.price)) AS Pizza_price, bp.cost + (SUM(t.cost_per_unit)) AS Pizza_cost
--     FROM ((Pizza AS p join BasePrice AS bp ON p.base_price_id=bp.base_price_id) 
--         left join ToppingsOnPizza AS tp ON  p.pizza_id=tp.pizza_id )
--         left join Toppings AS t ON t.topping_name=tp.topping_name
--     GROUP BY  p.pizza_id;

SELECT x.pizza_size, AVG(x.Pizza_price) AS "Average pizza price", AVG(Pizza_cost) AS "Average pizza price"
FROM (
    SELECT pizza_size, bp.price + (SUM(t.price)) AS Pizza_price,
        CASE 
            WHEN pizza_size = 'small' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_personal)) 
            WHEN pizza_size = 'medium' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_medium)) 
            WHEN pizza_size = 'large' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_large)) 
            WHEN pizza_size = 'x-large' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_xlarge)) 
        END AS Pizza_cost
    FROM ((Pizza AS p join BasePrice AS bp ON p.base_price_id=bp.base_price_id) 
         left join ToppingsOnPizza AS tp ON  p.pizza_id=tp.pizza_id )
        left join Toppings AS t ON t.topping_name=tp.topping_name
    GROUP BY  p.pizza_id
) x
GROUP BY x.pizza_size;