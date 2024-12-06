-- 1. Inventory report: For each topping in the database, show the topping name, the current
-- inventory level and the number of X-large pizzas that could be made using that amount of the
-- topping. Order alphabetically by topping name

SELECT topping_name, current_inventory_level, FLOOR(current_inventory_level / amount_used_xlarge) AS 'X-large pizzas that could be made'
FROM Toppings;

-- 2 Revenue Report
SELECT 
    SUM(total_price) AS revenue, SUM(total_cost) AS expenses, (SUM(total_price)-SUM(total_cost)) AS profit
FROM 
	Orders
GROUP BY 
	DATE(order_timestamp)
ORDER BY 
	DATE(order_timestamp);

-- 3. Customer report: For each customer in the database, display their name, the total number of
-- orders they have placed, the average of the order price, the total order price, the max order
-- price, and the minimum order price. Dine in orders should not be included.

SELECT customer_fname AS "First Name", customer_lname AS 'Last Name', count(c.customer_id) AS 'Number of orders placed',
        AVG(total_price), SUM(total_price), MAX(total_price), MIN(total_price)
FROM Customer AS c join Orders AS o ON c.customer_id=o.customer_id
GROUP BY c.customer_id;

-- 4 Dine in Order Report
SELECT 
    AVG(seat_count) AS average_seats_per_order,
    AVG(total_price) AS average_order_price,
    SUM(total_price) AS total_order_price,
    MAX(total_price) AS max_order_price,
    MIN(total_price) AS min_order_price
FROM 
	-- join DineIn, Seats, and Orders tables to get the order_id, seat_count, and total_price
    (SELECT 
        DineIn.order_id, 
		-- used to get average number of seats per order
        COUNT(Seats.seat_number) AS seat_count, 
        total_price
    FROM 
        DineIn
    JOIN 
        Seats ON DineIn.order_id = Seats.order_id
    JOIN 
        Orders ON DineIn.order_id = Orders.order_id
    GROUP BY 
        DineIn.order_id, total_price) AS seat_count_table;


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
-- 6 Order type report: For each day and order type (delivery, pick-up, dine-in), display the total
-- number of orders, the total number of pizzas on those orders, and the total order price of all
-- the orders. Order by date, then order type.
SELECT 
    DATE(order_timestamp) AS 'Date',
    order_type AS 'Order Type',
    COUNT(order_id) AS 'Total Orders',
        SUM(total_pizzas) AS 'Total Pizzas',
    SUM(total_price) AS 'Total Order Price'
FROM
    (SELECT 
        Orders.order_id,
        Orders.order_timestamp,
        'delivery' AS order_type,
        total_price,
        (SELECT 
            COUNT(pizza_id)
        FROM 
            Pizza
        WHERE 
            order_id = Orders.order_id) AS total_pizzas
    FROM 
        Delivery
    JOIN 
        Orders ON Delivery.order_id = Orders.order_id
    UNION ALL
    SELECT 
        Orders.order_id,
        Orders.order_timestamp,
        'pickup' AS order_type,
        total_price,
        (SELECT 
            COUNT(pizza_id)
        FROM 
            Pizza
        WHERE 
            order_id = Orders.order_id) AS total_pizzas
    FROM 
        Pickup
    JOIN 
        Orders ON Pickup.order_id = Orders.order_id
    UNION ALL
    SELECT 
        Orders.order_id,
        Orders.order_timestamp,
        'dine-in' AS order_type,
        total_price,
        (SELECT 
            COUNT(pizza_id)
        FROM 
            Pizza
        WHERE 
            order_id = Orders.order_id) AS total_pizzas
    FROM 
        DineIn
    JOIN 
        Orders ON DineIn.order_id = Orders.order_id) AS order_type_table
GROUP BY DATE(order_timestamp), order_type
ORDER BY DATE(order_timestamp), order_type;

--  7. Discount report: For each discount, display the discount name and the count of orders that used
-- that discount, and the total money saved by customers from using that discount.

SELECT discount_name AS "Discount", count(dp.discount_id) + count(do.discount_id) AS 'Times used',
 IFNULL(SUM(o.total_price * (d.percentage_off / 100)),0) + IFNULL(SUM(d.amount_off),0) AS 'total money saved'
FROM ((Discount AS d left join DiscountOnPizza AS dp ON d.discount_id=dp.discount_id) 
      left join DiscountOnOrder AS do ON d.discount_id=do.discount_id) left join Orders AS o ON o.order_id=do.order_id
GROUP BY d.discount_id;

-- 8 Inventory Usage Report
-- Inventory usage: For each topping, show the name and the total amount used (even if it is 0) on
-- March 3rd. Order by Topping name.

SELECT 
    t.topping_name,
    SUM(
        CASE 
            WHEN DATE(o.order_timestamp) = '2024-03-03' THEN 
                CASE 
                            WHEN p.base_price_id IN (1, 2, 3, 4) THEN t.amount_used_personal
                            WHEN p.base_price_id IN (5, 6, 7, 8) THEN t.amount_used_medium
                            WHEN p.base_price_id IN (9, 10, 11, 12) THEN t.amount_used_large
                            WHEN p.base_price_id IN (13, 14, 15, 16) THEN t.amount_used_xlarge
                            ELSE 0 
                END
            ELSE 0
        END
    ) AS total_amount_used
FROM 
    Toppings t
LEFT JOIN 
    ToppingsOnPizza top ON t.topping_name = top.topping_name
LEFT JOIN 
    Pizza p ON top.pizza_id = p.pizza_id
LEFT JOIN 
    Orders o ON p.order_id = o.order_id
GROUP BY 
    t.topping_name
ORDER BY 
    t.topping_name;
-- 9. Pizza Size report: For each Pizza size, show the total number of pizzas ordered, average price,
-- and average cost of those pizzas.

SELECT x.pizza_size, COUNT(x.pizza_size) AS "Total number of pizzas", AVG(x.Pizza_price) AS "Average pizza price", AVG(Pizza_cost) AS "Average pizza cost"
FROM (
    SELECT pizza_size, (bp.price + (SUM(t.price)) - IFNULL(MIN(d.amount_off),0)) AS Pizza_price,
        CASE 
            WHEN pizza_size = 'small' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_personal)) 
            WHEN pizza_size = 'medium' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_medium)) 
            WHEN pizza_size = 'large' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_large)) 
            WHEN pizza_size = 'x-large' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_xlarge)) 
        END AS Pizza_cost
    FROM ((((Pizza AS p join BasePrice AS bp ON p.base_price_id=bp.base_price_id) 
         left join ToppingsOnPizza AS tp ON  p.pizza_id=tp.pizza_id )
        left join Toppings AS t ON t.topping_name=tp.topping_name )
        left join DiscountOnPizza AS dp ON p.pizza_id=dp.pizza_id)
        left join Discount AS d ON d.discount_id=dp.discount_id
    GROUP BY  p.pizza_id
) x
GROUP BY x.pizza_size;

-- 10. Crust type report: For each crust type, show the total number of pizzas ordered, average price,
-- and average cost of those pizzas.

SELECT x.crust_type, COUNT(x.crust_type) AS "Total number of pizzas", AVG(x.Pizza_price) AS "Average pizza price", AVG(Pizza_cost) AS "Average pizza cost"
FROM (
    SELECT crust_type, (bp.price + (SUM(t.price)) - IFNULL(MIN(d.amount_off),0)) AS Pizza_price,
        CASE 
            WHEN pizza_size = 'small' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_personal)) 
            WHEN pizza_size = 'medium' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_medium)) 
            WHEN pizza_size = 'large' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_large)) 
            WHEN pizza_size = 'x-large' THEN bp.cost + (SUM(t.cost_per_unit * t.amount_used_xlarge)) 
        END AS Pizza_cost
    FROM ((((Pizza AS p join BasePrice AS bp ON p.base_price_id=bp.base_price_id) 
         left join ToppingsOnPizza AS tp ON  p.pizza_id=tp.pizza_id )
        left join Toppings AS t ON t.topping_name=tp.topping_name )
        left join DiscountOnPizza AS dp ON p.pizza_id=dp.pizza_id)
        left join Discount AS d ON d.discount_id=dp.discount_id
    GROUP BY  p.pizza_id
) x
GROUP BY x.crust_type;