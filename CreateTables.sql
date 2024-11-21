CREATE TABLE Toppings (
	topping_id INT,
	name VARCHAR(50),
	current_inventory_level INT,
	price_to_customer DECIMAL(10, 2),
	price_to_business DECIMAL(10, 2),
	amount_used_personal DECIMAL(10, 2),
	amount_used_medium DECIMAL(10, 2),
	amount_used_large DECIMAL(10, 2),
	amount_used_xlarge DECIMAL(10, 2),
	PRIMARY KEY(topping_id)
);

CREATE TABLE Pizza (
	pizza_id INT,
	crust_type ENUM('thin', 'original', 'pan', 'gluten free'),
	size ENUM('personal', 'medium', 'large', 'X-Large'),
	price DECIMAL(10, 2),
	cost DECIMAL(10, 2),
	status ENUM('completed', 'prepping'),
	order_timestamp TIMESTAMP,
	order_id INT,
	PRIMARY KEY(pizza_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);

CREATE TABLE ToppingsOnPizza (
	pizza_id INT,
	topping_id INT,
	amount ENUM('single', 'double'),
	PRIMARY KEY(pizza_id, topping_id),
	FOREIGN KEY(pizza_id) REFERENCES Pizza(pizza_id),
	FOREIGN KEY(topping_id) REFERENCES Toppings(topping_id)
);

CREATE TABLE Discount (
	discount_id INT,
	name VARCHAR(50),
	amount_off DECIMAL(10, 2),
	percentage_off DECIMAL(5, 2),
	PRIMARY KEY(discount_id)
);

CREATE TABLE DiscountOnPizza (
	pizza_id INT,
	discount_id INT,
	PRIMARY KEY(pizza_id, discount_id),
	FOREIGN KEY(pizza_id) REFERENCES Pizza(pizza_id),
	FOREIGN KEY(discount_id) REFERENCES Discount(discount_id)
);

CREATE TABLE DiscountOnOrder (
	order_id INT,
	discount_id INT,
	PRIMARY KEY(order_id, discount_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id),
	FOREIGN KEY(discount_id) REFERENCES Discount(discount_id)
);

CREATE TABLE BasePrice (
	base_price_id INT,
	--crust_type ENUM('thin', 'original', 'pan', 'gluten free'),
	--size ENUM('personal', 'medium', 'large', 'X-Large'),
	--price DECIMAL(10, 2),
	cost DECIMAL(10, 2),
	PRIMARY KEY(base_price_id)
);

CREATE TABLE Orders (
	order_id INT,
	total_cost DECIMAL(10, 2),
	total_price DECIMAL(10, 2),
	order_type ENUM('dine-in', 'pickup', 'delivery'),
	customer_id INT,
	PRIMARY KEY(order_id),
	FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Customer (
	customer_id INT,
	name VARCHAR(100),
	phone_number VARCHAR(15),
	address VARCHAR(255),
	PRIMARY KEY(customer_id)
);

CREATE TABLE Delivery (
	order_id INT,
	address VARCHAR(255),
	PRIMARY KEY(order_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Pickup (
	order_id INT,
	PRIMARY KEY(order_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);

CREATE TABLE DineIn (
	order_id INT,
	table_number INT,
	PRIMARY KEY(order_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Seats (
	seat_id INT,
	order_id INT,
	table_number INT,
	seat_number INT,
	PRIMARY KEY(seat_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);