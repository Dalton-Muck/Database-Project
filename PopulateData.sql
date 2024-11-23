-- Insert data into Toppings table
INSERT INTO Toppings (topping_name, price, cost_per_unit, current_inventory_level, amount_used_personal, amount_used_medium, amount_used_large, amount_used_xlarge)
VALUES 
('Pepperoni', 1.25, 0.2, 100, 2, 2.75, 3.5, 4.5),
('Sausage', 1.25, 0.15, 100, 2.5, 3, 3.5, 4.25),
('Ham', 1.5, 0.15, 78, 2, 2.5, 3.25, 4),
('Chicken', 1.75, 0.25, 56, 1.5, 2, 2.25, 3),
('Green Pepper', 0.5, 0.02, 79, 1, 1.5, 2, 2.5),
('Onion', 0.5, 0.02, 85, 1, 1.5, 2, 2.75),
('Roma tomato', 0.75, 0.03, 86, 2, 3, 3.5, 4.5),
('Mushrooms', 0.75, 0.1, 52, 1.5, 2, 2.5, 3),
('Black Olives', 0.6, 0.1, 39, 0.75, 1, 1.5, 2),
('Pineapple', 1, 0.25, 15, 1, 1.25, 1.75, 2),
('Jalapenos', 0.5, 0.05, 64, 0.5, 0.75, 1.25, 1.75),
('Banana Peppers', 0.5, 0.05, 36, 0.6, 1, 1.3, 1.75),
('Regular Cheese', 1.5, 0.12, 250, 2, 3.5, 5, 7),
('Four Cheese Blend', 2, 0.15, 150, 2, 3.5, 5, 7),
('Feta Cheese', 2, 0.18, 75, 1.75, 3, 4, 5.5),
('Goat Cheese', 2, 0.2, 54, 1.6, 2.75, 4, 5.5),
('Bacon', 1.5, 0.25, 89, 1, 1.5, 2, 3);

-- Insert data into Discount table
INSERT INTO Discount (discount_name, percentage_off, amount_off)
VALUES 
('employee', 15, NULL),
('Lunch Special Medium', NULL, 1),
('Lunch Special Large', NULL, 2),
('Specialty Pizza', NULL, 1.5),
('Gameday special', 20, NULL);

--Insert data into base price table
INSERT INTO BasePrice (base_price_id,pizza_size,crust_type,price,cost)
VALUES
(1,'small','Thin',3,0.5),
(2,'small','Original',3,0.75),
(3,'small','Pan',3.5,1),
(4,'small', 'Gluten-Free',4,2),
(5,'medium','Thin',5,1),
(6,'medium','Original',5,1.5),
(7,'medium','Pan',6,2.25),
(8,'medium','Gluten-Free',6.25,3),
(9,'large','Thin',8,1.25),
(10,'large','Original',8,2),
(11,'large','Pan',9,3),
(12,'large', 'Gluten-Free',9.5,4),
(13,'x-large','Thin',10,2),
(14,'x-large','Original',10,3),
(15,'x-large','Pan',11.5,4.5),
(16,'x-large','Gluten-Free',12.5,6);


-- Insert data into Orders table

INSERT INTO Orders (order_id,total_cost,total_price,order_status, order_timestamp,customer_id)
VALUES
(1,3.68,13.5,'completed','2024-03-05 12:03',NULL);

INSERT INTO DineIn (order_id,table_number)
VALUES
(1,14);

INSERT INTO Seats (order_id,seat_number)
VALUES
(1,1),
(1,2),
(1,3);

INSERT INTO Pizza (pizza_id,crust_type,pizza_size,order_id)
VALUES
(1,'Thin','large',1);

INSERT INTO ToppingsOnPizza (pizza_id,topping_name,amount)
VALUES
(1,'Regular Cheese','extra'),
(1,'Pepperoni','regular'),
(1,'Sausage','regular');

