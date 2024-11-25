CREATE TABLE Customer (
	customer_id INT,
	customer_fname VARCHAR(100),
	customer_lname VARCHAR(100),
	phone_number VARCHAR(15),
	customer_address VARCHAR(255),
	PRIMARY KEY(customer_id)
);

CREATE TABLE Orders (
	order_id INT,
	total_cost DECIMAL(10, 2),
	total_price DECIMAL(10, 2),
	order_status VARCHAR(50),
	order_timestamp TIMESTAMP,
	customer_id INT,
	PRIMARY KEY(order_id),
	FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE DineIn (
	order_id INT,
	table_number INT,
	PRIMARY KEY(order_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Seats (
	order_id INT,
	seat_number INT,
	PRIMARY KEY(order_id,seat_number),
	FOREIGN KEY(order_id) REFERENCES DineIn(order_id)
);

CREATE TABLE Delivery (
	order_id INT,
	PRIMARY KEY(order_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Pickup (
	order_id INT,
	PRIMARY KEY(order_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Toppings (
	topping_name VARCHAR(50),
	price DECIMAL(10,2),
	cost_per_unit DECIMAL(10, 2),
	current_inventory_level INT,
	amount_used_personal DECIMAL(10, 2),
	amount_used_medium DECIMAL(10, 2),
	amount_used_large DECIMAL(10, 2),
	amount_used_xlarge DECIMAL(10, 2),
	PRIMARY KEY(topping_name)
);

CREATE TABLE BasePrice (
	pizza_size VARCHAR(50),
	crust_type VARCHAR(50),
	base_price_id INT,
	cost DECIMAL(10, 2),
	price DECIMAL(10,2),
	PRIMARY KEY(base_price_id)
);


CREATE TABLE Pizza (
	pizza_id INT,
	base_price_id INT,
	order_id INT,
	PRIMARY KEY(pizza_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id),
	FOREIGN KEY(base_price_id) REFERENCES BasePrice(base_price_id)
);

CREATE TABLE ToppingsOnPizza (
	pizza_id INT,
	topping_name VARCHAR(50),
	amount VARCHAR(50),
	PRIMARY KEY(pizza_id, topping_name),
	FOREIGN KEY(pizza_id) REFERENCES Pizza(pizza_id),
	FOREIGN KEY(topping_name) REFERENCES Toppings(topping_name)
);

CREATE TABLE Discount (
	discount_id INT,
	discount_name VARCHAR(50),
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