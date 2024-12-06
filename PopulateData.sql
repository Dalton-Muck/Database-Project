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
INSERT INTO Discount (discount_id,discount_name, percentage_off, amount_off)
VALUES 
(1,'employee', 15, NULL),
(2,'Lunch Special Medium', NULL, 1),
(3,'Lunch Special Large', NULL, 2),
(4,'Specialty Pizza', NULL, 1.5),
(5,'Gameday special', 20, NULL);

-- Insert data into base price table
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

INSERT INTO Customer (customer_id,customer_fname,customer_lname,phone_number,customer_address)
VALUES
(1,'Andrew','Wilkes-Krier','740-254-5861','15 Party Blvd, Athens OH 45701'),
(2,'Matt','Engers','740-474-9953',NULL),
(3,'Frank','Turner','740-232-8944','6745 Wessex St Athens OH 45701'),
(4,'Milo','Auckerman','740-878-5679','o 8879 Suburban Home Athens OH 45701');


INSERT INTO Orders (order_id, total_price,total_cost, order_status, order_timestamp,customer_id)
VALUES
(1,13.5,3.68,'completed','2024-03-05 12:03',NULL),
(2,10.6,3.23,'completed','2024-03-03 12:05',NULL),
(3,6.75,1.4,'completed','2024-03-03 12:05',NULL),
(4,64.5,19.8,'completed','2024-03-03 21:30',1),
(5,45.5,16.86,'completed','2024-03-05 19:11',1),
(6,16.85,7.85,'completed','2024-03-02 17:30',2),
(7,13.25,3.2,'completed','2024-03-02 18:17',3),
(8,24,6.3,'completed','2024-03-06 20:32',4);

INSERT INTO DineIn (order_id,table_number)
VALUES
(1,14),
(2,4),
(3,4);

INSERT INTO Seats (order_id,seat_number)
VALUES
(1,1),
(1,2),
(1,3),
(2,1),
(3,2);

INSERT INTO Pickup (order_id)
VALUES
(4),
(6);

INSERT INTO Delivery (order_id)
VALUES
(5),
(7),
(8);

INSERT INTO Pizza (pizza_id,base_price_id,order_id)
VALUES
(1,9,1),-- (1,'Thin','large',13.50,3.68,1),
(2,7,2),-- (2,'Pan','medium',10.60,3.23,2),
(3,2,3),-- (3,'Original','small',6.75,1.40,3),
(4,10,4), -- (4,'Original','large',10.75,3.30,4),
(5,10,4),-- (5,'Original','large',10.75,3.30,4),
(6,10,4),-- (6,'Original','large',10.75,3.30,4),
(7,10,4),-- (7,'Original','large',10.75,3.30,4),
(8,10,4), -- (8,'Original','large',10.75,3.30,4),
(9,10,4),-- (9,'Original','large',10.75,3.30,4),
(10,14,5),-- (10,'Original','x-large',14.50,5.68,5),
(11,14,5),-- (11,'Original','x-large',17,5.59,5),
(12,14,5),-- (12,'Original','x-large',14,5.68,5),
(13,16,6),-- (13,'Gluten-Free','x-large',16.85,7.85,6),
(14,13,7),-- (14,'Thin','x-large',13.25,3.20,7),
(15,9,8),-- (15,'Thin','large',12,3.75,8),
(16,9,8);-- (16,'Thin','large',12,2.55,8);

INSERT INTO ToppingsOnPizza (pizza_id,topping_name,amount)
VALUES
(1,'Regular Cheese','extra'),
(1,'Pepperoni','regular'),
(1,'Sausage','regular'),
(2,'Feta Cheese','regular'),
(2,'Black Olives','regular'),
(2,'Roma tomato','regular'),
(2,'Mushrooms','regular'),
(2,'Banana Peppers','regular'),
(3,'Regular Cheese','regular'),
(3,'Chicken','regular'),
(3,'Banana Peppers','regular'),
(4,'Regular Cheese','regular'),
(4,'Pepperoni','regular'),
(5,'Regular Cheese','regular'),
(5,'Pepperoni','regular'),
(6,'Regular Cheese','regular'),
(6,'Pepperoni','regular'),
(7,'Regular Cheese','regular'),
(7,'Pepperoni','regular'),
(8,'Regular Cheese','regular'),
(8,'Pepperoni','regular'),
(9,'Regular Cheese','regular'),
(9,'Pepperoni','regular'),
(10,'Four Cheese Blend','regular'),
(10,'Pepperoni','regular'),
(10,'Sausage','regular'),
(11,'Four Cheese Blend','regular'),
(11,'Ham','extra'),
(11,'Pineapple','extra'),
(12,'Four Cheese Blend','regular'),
(12,'Jalapenos','regular'),
(12,'Bacon','regular'),
(13,'Green Pepper','regular'),
(13,'Onion','regular'),
(13,'Mushrooms','regular'),
(13,'Black Olives','regular'),
(13,'Goat Cheese','regular'),
(14,'Chicken','regular'),
(14,'Green Pepper','regular'),
(14,'Onion','regular'),
(14,'Mushrooms','regular'),
(14,'Four Cheese Blend','regular'),
(15,'Four Cheese Blend','extra'),
(16,'Regular Cheese','regular'),
(16,'Pepperoni','extra');


Insert INTO DiscountOnPizza (pizza_id,discount_id)
VALUES
(1,3),
(2,2),
(2,4),
(11,4),
(13,4);

INSERT INTO DiscountOnOrder (order_id,discount_id)
VALUES
(5,5),
(8,1);
