-- Create Salesperson Table
CREATE TABLE Salesperson (
    Salesperson_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255)
);

-- Create Customer Table
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255)
);

-- Create Car Table
CREATE TABLE Car (
    SerialNumber INT PRIMARY KEY,
    Make VARCHAR(255),
    Model VARCHAR(255),
    Year INT,
    Price DECIMAL(10, 2),
    Condition VARCHAR(10) -- New or Used
);

-- Create ServiceTicket Table
CREATE TABLE ServiceTicket (
    TicketNumber INT PRIMARY KEY,
    Date DATE,
    Description TEXT,
    Customer_ID INT,
    Car_SerialNumber INT,
    Salesperson_ID INT
);

-- Create ServiceHistory Table
CREATE TABLE ServiceHistory (
    ServiceHistory_ID INT PRIMARY KEY,
    Car_SerialNumber INT,
    Date DATE,
    Description TEXT,
    ServicePerformed TEXT,
    Cost DECIMAL(10, 2)
);

-- Create Mechanic Table
CREATE TABLE Mechanic (
    Mechanic_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255)
);

-- Create CarMechanic (Join) Table for Many-to-Many Relationship
CREATE TABLE CarMechanic (
    Car_SerialNumber INT,
    Mechanic_ID INT,
    PRIMARY KEY (Car_SerialNumber, Mechanic_ID)
);

-- Create ServicePart Table (for tracking parts needed during service)
CREATE TABLE ServicePart (
    Part_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT
);

-- Create ServiceTicketPart (Join) Table for Many-to-Many Relationship
CREATE TABLE ServiceTicketPart (
    TicketNumber INT,
    Part_ID INT,
    Quantity INT,
    PRIMARY KEY (TicketNumber, Part_ID)
);


-- Insert Sample Data into Salesperson Table
INSERT INTO Salesperson (Salesperson_ID, Name, ContactInfo)
VALUES
    (1, 'John Smith', 'john@example.com'),
    (2, 'Mary Johnson', 'mary@example.com');

-- Insert Sample Data into Customer Table
INSERT INTO Customer (Customer_ID, Name, ContactInfo)
VALUES
    (1, 'Alice Brown', 'alice@example.com'),
    (2, 'Bob Davis', 'bob@example.com');

-- Insert Sample Data into Car Table
INSERT INTO Car (SerialNumber, Make, Model, Year, Price, Condition)
VALUES
    (1001, 'Toyota', 'Camry', 2022, 25000.00, 'New'),
    (1002, 'Honda', 'Civic', 2020, 18000.00, 'Used');

-- Insert Sample Data into ServiceTicket Table
INSERT INTO ServiceTicket (TicketNumber, Date, Description, Customer_ID, Car_SerialNumber, Salesperson_ID)
VALUES
    (5001, '2023-10-01', 'Regular Service', 1, 1001, 1),
    (5002, '2023-10-05', 'Oil Change', 2, 1002, 2);

-- Insert Sample Data into ServiceHistory Table
INSERT INTO ServiceHistory (ServiceHistory_ID, Car_SerialNumber, Date, Description, ServicePerformed, Cost)
VALUES
    (7001, 1001, '2023-10-01', 'Regular Service', 'Oil Change, Brake Check', 100.00),
    (7002, 1002, '2023-10-05', 'Oil Change', 'Oil Change', 50.00);

-- Insert Sample Data into Mechanic Table
INSERT INTO Mechanic (Mechanic_ID, Name, ContactInfo)
VALUES
    (101, 'Mike Brown', 'mike@example.com'),
    (102, 'Sarah Johnson', 'sarah@example.com');

-- Insert Sample Data into CarMechanic Table
INSERT INTO CarMechanic (Car_SerialNumber, Mechanic_ID)
VALUES
    (1001, 101),
    (1002, 102);

-- Insert Sample Data into ServicePart Table
INSERT INTO ServicePart (Part_ID, Name, Description)
VALUES
    (201, 'Oil Filter', 'Replacement oil filter'),
    (202, 'Brake Pad', 'Replacement brake pad');

-- Insert Sample Data into ServiceTicketPart Table
INSERT INTO ServiceTicketPart (TicketNumber, Part_ID, Quantity)
VALUES
    (5001, 201, 1),
    (5002, 201, 1),
    (5001, 202, 2);
   
   
CREATE OR REPLACE FUNCTION insert_salesperson(p_name VARCHAR(255), p_contact_info VARCHAR(255))
RETURNS VOID AS $$
BEGIN
    INSERT INTO Salesperson (Name, ContactInfo) VALUES (p_name, p_contact_info);
END;
$$ LANGUAGE plpgsql;

-- Sample Stored Function 2: Insert Customer Data
CREATE OR REPLACE FUNCTION insert_customer(p_name VARCHAR(255), p_contact_info VARCHAR(255))
RETURNS VOID AS $$
BEGIN
    INSERT INTO Customer (Name, ContactInfo) VALUES (p_name, p_contact_info);
END;
$$ LANGUAGE plpgsql;

-- Use the Stored Functions to Insert Data
-- Insert a Salesperson
SELECT insert_salesperson('David Johnson', 'david@example.com');

-- Insert a Customer
SELECT insert_customer('Eve Smith', 'eve@example.com');

-- Insert Data Without Stored Functions
INSERT INTO Salesperson (Name, ContactInfo) VALUES ('John Doe', 'john@example.com');
INSERT INTO Customer (Name, ContactInfo) VALUES ('Alice Brown', 'alice@example.com');

-- Display Data
SELECT * FROM Salesperson;
SELECT * FROM Customer;
select *
from Salesperson, Customer, Car, ServiceTicket, ServiceHistory, Mechanic, CarMechanic, ServicePart
