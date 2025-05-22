use Airline

-- AIRPORT
CREATE TABLE Airport (
    airport_code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

-- AIRPLANE_TYPE
CREATE TABLE Airplane_Type (
    type_name VARCHAR(50) PRIMARY KEY,
    company VARCHAR(50),
    max_seats INT
);

-- AIRPLANE
CREATE TABLE Airplane (
    airplane_id VARCHAR(20) PRIMARY KEY,
    total_seats INT,
    type_name VARCHAR(50),
    FOREIGN KEY (type_name) REFERENCES Airplane_Type(type_name)
);

-- AIRPORT_AIRPLANE_TYPE (junction table)
CREATE TABLE Airport_Airplane_Type (
    airport_code VARCHAR(10),
    type_name VARCHAR(50),
    PRIMARY KEY (airport_code, type_name),
    FOREIGN KEY (airport_code) REFERENCES Airport(airport_code),
    FOREIGN KEY (type_name) REFERENCES Airplane_Type(type_name)
);

-- FLIGHT
CREATE TABLE Flight (
    flight_id VARCHAR(20) PRIMARY KEY,
    airline VARCHAR(50),
    weekdays VARCHAR(20),
    restrictions TEXT
);

-- FLIGHT_LEG
CREATE TABLE Flight_Leg (
    leg_no VARCHAR(20) PRIMARY KEY,
    flight_id VARCHAR(20),
    dep_airport VARCHAR(10),
    arr_airport VARCHAR(10),
    scheduled_dep_time TIME,
    scheduled_arr_time TIME,
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
    FOREIGN KEY (dep_airport) REFERENCES Airport(airport_code),
    FOREIGN KEY (arr_airport) REFERENCES Airport(airport_code)
);

-- LEG_INSTANCE
CREATE TABLE Leg_Instance (
    instance_id INT PRIMARY KEY,
    leg_no VARCHAR(20),
    flight_date DATE,
    airplane_id VARCHAR(20),
    actual_dep_time TIME,
    actual_arr_time TIME,
    available_seats INT,
    FOREIGN KEY (leg_no) REFERENCES Flight_Leg(leg_no),
    FOREIGN KEY (airplane_id) REFERENCES Airplane(airplane_id)
);

-- RESERVATION
CREATE TABLE Reservation (
    reservation_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_phone VARCHAR(20),
    instance_id INT,
    seat_number VARCHAR(5),
    FOREIGN KEY (instance_id) REFERENCES Leg_Instance(instance_id)
);

-- FARE
CREATE TABLE Fare (
    fare_code VARCHAR(10) PRIMARY KEY,
    flight_id VARCHAR(20),
    amount DECIMAL(10, 2),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

-- Airports
INSERT INTO Airport VALUES ('JFK', 'John F. Kennedy International', 'New York', 'NY');
INSERT INTO Airport VALUES ('LAX', 'Los Angeles International', 'Los Angeles', 'CA');

-- Airplane Types
INSERT INTO Airplane_Type VALUES ('Boeing737', 'Boeing', 180);
INSERT INTO Airplane_Type VALUES ('AirbusA320', 'Airbus', 160);

-- Airplanes
INSERT INTO Airplane VALUES ('A100', 180, 'Boeing737');
INSERT INTO Airplane VALUES ('A200', 160, 'AirbusA320');

-- Airport-Airplane Type Capability
INSERT INTO Airport_Airplane_Type VALUES ('JFK', 'Boeing737');
INSERT INTO Airport_Airplane_Type VALUES ('LAX', 'Boeing737');
INSERT INTO Airport_Airplane_Type VALUES ('JFK', 'AirbusA320');
INSERT INTO Airport_Airplane_Type VALUES ('LAX', 'AirbusA320');

-- Flights
INSERT INTO Flight VALUES ('F100', 'Delta Airlines', 'Mon,Wed,Fri', 'No pets allowed');
INSERT INTO Flight VALUES ('F200', 'United Airlines', 'Tue,Thu,Sun', NULL);

-- Flight Legs
INSERT INTO Flight_Leg VALUES ('L1', 'F100', 'JFK', 'LAX', '08:00:00', '11:00:00');
INSERT INTO Flight_Leg VALUES ('L2', 'F200', 'LAX', 'JFK', '12:00:00', '20:00:00');

-- Leg Instances
INSERT INTO Leg_Instance VALUES (1, 'L1', '2025-06-01', 'A100', '08:05:00', '11:15:00', 50);
INSERT INTO Leg_Instance VALUES (2, 'L2', '2025-06-02', 'A200', '12:10:00', '20:20:00', 40);

-- Reservations
INSERT INTO Reservation VALUES (101, 'Alice Smith', '555-1234', 1, '12A');
INSERT INTO Reservation VALUES (102, 'Bob Johnson', '555-5678', 2, '15C');

-- Fares
INSERT INTO Fare VALUES ('ECO1', 'F100', 199.99);
INSERT INTO Fare VALUES ('BUS1', 'F100', 499.99);
