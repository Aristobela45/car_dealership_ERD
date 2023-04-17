-- Once the database has been created, each person should create their own database inside of PGAdmin. Also, once the database and the tables are created, 
--each person should have AT LEAST 4 pieces/records of data inside of the tables. (You can add more if you want)

-- At least 3 of the inserts should come from a stored function but you can, and it is recommended, 
--to do all of them this way.. (You can always add more if you want)
CREATE OR REPLACE FUNCTION add_customer(first_name VARCHAR, last_name VARCHAR, address VARCHAR, phone_number VARCHAR)
RETURNS VOID AS $$
BEGIN
	INSERT INTO Customer(first_name, last_name, address, phone_number)
	VALUES (first_name, last_name, address, phone_number);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_vehicle(vehicle_vin VARCHAR, vehicle_year INTEGER, make VARCHAR, model VARCHAR, customer_id INTEGER)
RETURNS VOID AS $$
BEGIN
	INSERT INTO Vehicle(vehicle_vin, vehicle_year, make, model, customer_id)
	VALUES (vehicle_vin, vehicle_year, make, model, customer_id);
END;
$$ LANGUAGE plpgsql;

---rename my vin column & year in vehicle table
ALTER TABLE public.vehicle RENAME vin TO vehicle_vin
ALTER TABLE public.vehicle RENAME year TO vehicle_year


CREATE OR REPLACE FUNCTION add_sales_staff(first_name VARCHAR, last_name VARCHAR)
RETURNS VOID AS $$
BEGIN
	INSERT INTO Sales_Staff(first_name, last_name)
	VALUES (first_name, last_name);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_service_staff(first_name VARCHAR, last_name VARCHAR)
RETURNS VOID AS $$
BEGIN
	INSERT INTO Service_Staff(first_name, last_name)
	VALUES (first_name, last_name);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_invoice_vehicle(sale_date DATE, sale_price DECIMAL(10,2), sales_staff_id INTEGER, vehicle_id INTEGER)
RETURNS VOID AS $$
BEGIN
	INSERT INTO Invoice_Vehicle(sale_date, sale_price, sales_staff_id, vehicle_id)
	VALUES (sale_date, sale_price, sales_staff_id, vehicle_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_service_ticket(service_description VARCHAR, service_date DATE, mileage INTEGER, service_fee DECIMAL(10,2), service_staff_id INTEGER, vehicle_id INTEGER)
RETURNS VOID AS $$
BEGIN
	INSERT INTO Service_Ticket(service_description, service_date, mileage, service_fee, service_staff_id, vehicle_id)
	VALUES (service_description, service_date, mileage, service_fee, service_staff_id, vehicle_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_mechanic_staff(first_name VARCHAR, last_name VARCHAR)
RETURNS VOID AS $$
BEGIN
	INSERT INTO Mechanic_Staff(first_name, last_name)
	VALUES (first_name, last_name);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_mechanic_service(mechanic_staff_id INTEGER, service_ticket_id INTEGER)
RETURNS VOID AS $$
BEGIN
	INSERT INTO Mechanic_Service(mechanic_staff_id, service_ticket_id)
	VALUES (mechanic_staff_id, service_ticket_id);
END;
$$ LANGUAGE plpgsql;


SELECT add_customer('Aristo', 'Bela', '354 Wilshire Ave', '213-456-2234');
SELECT add_customer('Walter', 'White', '688 5th st', '505-242-1123');
SELECT add_customer('Jesse', 'Pinkman', '12 Avallane Way', '505-453-9111');
SELECT add_customer('Gus', 'Fring', '45 Kill St', '505-666-1166');

SELECT *
FROM Customer;

SELECT add_vehicle('11bb', 1990, 'Mercedes-Benz', '500 SL', 1);
SELECT add_vehicle('22cc', 1998, 'BMW', 'M3', 2);
SELECT add_vehicle('33cc', 2001, 'BMW', '740i', 3);
SELECT add_vehicle('44dd', 2002, 'Mercedes-Benz', 'G-Wagon', 4);

SELECT *
FROM Vehicle;

SELECT add_sales_staff('Jake', 'Gyllenhall');
SELECT add_sales_staff('Denzel', 'Washington');
SELECT add_sales_staff('Leonardo', 'Dicaprio');
SELECT add_sales_staff('Jackie', 'Chan');

SELECT *
FROM Sales_Staff

SELECT add_service_staff('Tyson', 'Fury');
SELECT add_service_staff('Deontay', 'Wilder');
SELECT add_service_staff('Anthony', 'Joshua');
SELECT add_service_staff('Oleksandr', 'Usyk');

SELECT *
FROM Service_Staff


SELECT add_invoice_vehicle('Jan 2, 2023', 7000.00, 1, 1);
SELECT add_invoice_vehicle('Dec 6, 2023', 5000.00, 2, 2);
SELECT add_invoice_vehicle('Nov 10, 2023', 10000.00, 3, 3);
SELECT add_invoice_vehicle('Oct 15, 2023', 15000.00, 4, 4);

SELECT *
FROM Invoice_Vehicle

SELECT *
FROM sales_staff


SELECT add_service_ticket('oil change', 'Jan 2, 2023', 78000, 108.00, 1, 1);
SELECT add_service_ticket('engine change', 'Dec 6, 2023', 200000, 3000.00, 2, 2);
SELECT add_service_ticket('transmission change', 'Nov 10, 2023', 108000, 800.00, 3, 3);
SELECT add_service_ticket('gas leak', 'Oct 15, 2023', 90000, 7000.00, 4, 4);

SELECT *
FROM Service_Ticket

SELECT add_mechanic_staff('James', 'Brown');
SELECT add_mechanic_staff('Suga', 'Shay');
SELECT add_mechanic_staff('Joe', 'Joyce');
SELECT add_mechanic_staff('Earnest', 'Brown');

SELECT *
FROM Mechanic_Staff


SELECT add_mechanic_service(1, 5);
SELECT add_mechanic_service(2, 6);
SELECT add_mechanic_service(4, 7);
SELECT add_mechanic_service(3, 8);

SELECT *
FROM Mechanic_Service

SELECT *
FROM service_ticket




-- One of the rules states that just because a vehicle is serviced doesn't mean it was purchased there 
--(while that is likely) and just because a vehicle is purchased doesn't mean it receives service.

-- After your database is complete ADD a column to your vehicle table called "is_serviced"
ALTER TABLE "vehicle" ADD COLUMN "is_serviced" BOOLEAN;
UPDATE vehicle SET is_serviced = false;
-- Create a procedure to update a purchased vehicle's  service boolean if it had not previously received service but then comes in for an oil change. 
CREATE OR REPLACE PROCEDURE update_vehicle_service (IN _vehicle_id INTEGER)
AS $$
BEGIN
	UPDATE vehicle
	SET is_serviced = true
	WHERE vehicle_id = _vehicle_id AND is_serviced = false;
END $$
LANGUAGE plpgsql;

CALL update_vehicle_service(1);
CALL update_vehicle_service(2);
CALL update_vehicle_service(3);
CALL update_vehicle_service(4);