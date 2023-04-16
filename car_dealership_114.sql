CREATE TABLE Customer (
  customer_id SERIAL PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR,
  address VARCHAR,
  phone_number VARCHAR
);

CREATE TABLE Vehicle (
  vehicle_id SERIAL PRIMARY KEY,
  vehicle_vin VARCHAR,
  vehicle_year INTEGER,
  make VARCHAR,
  model VARCHAR,
  customer_id INTEGER,
    FOREIGN KEY (customer_id)
    REFERENCES Customer(customer_id)
);


CREATE TABLE Sales_Staff (
  sales_staff_id SERIAL PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR
);

CREATE TABLE Service_Staff (
  service_staff_id SERIAL PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR
);

CREATE TABLE Invoice_Vehicle (
  invoice_vehicle_id SERIAL PRIMARY KEY,
  sale_date DATE,
  sale_price DECIMAL(10,2),
  sales_staff_id INTEGER,
  vehicle_id INTEGER,
    FOREIGN KEY (sales_staff_id)
    REFERENCES Sales_Staff(sales_staff_id),
    FOREIGN KEY (vehicle_id)
    REFERENCES Vehicle(vehicle_id)
);

CREATE TABLE Service_Ticket (
  service_ticket_id SERIAL PRIMARY KEY,
  service_description VARCHAR,
  service_date DATE,
  mileage INTEGER,
  service_fee DECIMAL(10,2),
  service_staff_id INTEGER,
  vehicle_id INTEGER,
    FOREIGN KEY (vehicle_id)
    REFERENCES Vehicle(vehicle_id),
    FOREIGN KEY (service_staff_id)
    REFERENCES Service_Staff(service_staff_id)
);

CREATE TABLE Mechanic_Staff (
  mechanic_staff_id SERIAL PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR
);

CREATE TABLE Mechanic_Service (
  mechanic_service_id SERIAL PRIMARY KEY,
  mechanic_staff_id INTEGER,
  service_ticket_id INTEGER,
    FOREIGN KEY (mechanic_staff_id)
    REFERENCES Mechanic_Staff(mechanic_staff_id),
    FOREIGN KEY (service_ticket_id)
    REFERENCES Service_Ticket(service_ticket_id)
);