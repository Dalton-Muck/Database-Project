-- Insert data into Toppings table
INSERT INTO Toppings (customer_name, price_to_customer, price_to_business, current_inventory_level, amount_used_personal, amount_used_medium, amount_used_large, amount_used_xlarge)
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
INSERT INTO Discount (customer_name, percentage_off, amount_off)
VALUES 
('employee', 15, NULL),
('Lunch Special Medium', NULL, 1),
('Lunch Special Large', NULL, 2),
('Specialty Pizza', NULL, 1.5),
('Gameday special', 20, NULL);

-- Insert data into Orders table

-- Insert data into Customer table
INSERT INTO Customer (customer_name, phone_number, customer_address)
VALUES
('Andrew Wilkes-Krier', '740-254-5861', '115 Party Blvd, Athens OH 45701'),
('Matt Engers', '740-474-9953', NULL),
('Frank Turner', '740-232-8944', '6745 Wessex St Athens OH 45701'),
('Milo Auckerman', '740-878-5679', '8879 Suburban Home, Athens OH 45701');

-- Insert data into Orders table
INSERT INTO Orders (total_cost, total_price, order_type, customer_id)
VALUES
(3.68, 13.50, 'dine-in', NULL),
(3.23, 10.60, 'dine-in', NULL),
(1.40, 6.75, 'dine-in', NULL),
(3.30 * 6, 10.75 * 6, 'pickup', (SELECT customer_id FROM Customer WHERE customer_name = 'Andrew Wilkes-Krier')),
(5.59 + 5.59 + 5.68, 14.50 + 17 + 14.00, 'delivery', (SELECT customer_id FROM Customer WHERE customer_name = 'Andrew Wilkes-Krier')),
(7.85, 16.85, 'pickup', (SELECT customer_id FROM Customer WHERE customer_name = 'Matt Engers')),
(3.20, 13.25, 'delivery', (SELECT customer_id FROM Customer WHERE customer_name = 'Frank Turner')),
(3.75 + 2.55, 12 + 12, 'delivery', (SELECT customer_id FROM Customer WHERE customer_name = 'Milo Auckerman'));

-- Insert data into DiscountOnOrder table
INSERT INTO DiscountOnOrder (order_id, discount_id)
VALUES
((SELECT order_id FROM Orders WHERE total_price = 13.50), (SELECT discount_id FROM Discount WHERE customer_name = 'Lunch Special Large')),
((SELECT order_id FROM Orders WHERE total_price = 10.60), (SELECT discount_id FROM Discount WHERE customer_name = 'Lunch Special Medium')),
((SELECT order_id FROM Orders WHERE total_price = 16.85), (SELECT discount_id FROM Discount WHERE customer_name = 'Specialty Pizza')),
((SELECT order_id FROM Orders WHERE total_price = 14.50 + 17 + 14.00), (SELECT discount_id FROM Discount WHERE customer_name = 'Gameday special')),
((SELECT order_id FROM Orders WHERE total_price = 12 + 12), (SELECT discount_id FROM Discount WHERE customer_name = 'employee'));