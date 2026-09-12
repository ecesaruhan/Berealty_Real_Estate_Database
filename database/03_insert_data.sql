INSERT INTO agents (first_name, last_name, email, phone, hire_date)
VALUES
('Anna', 'Schmidt', 'anna.schmidt@berealty.de', '+49 30 12345678', '2023-03-15'),
('David', 'Muller', 'david.muller@berealty.de', '+49 30 23456789', '2022-07-10'),
('Sophie', 'Weber', 'sophie.weber@berealty.de', '+49 30 34567890', '2024-01-20'),
('Michael', 'Fischer', 'michael.fischer@berealty.de', '+49 30 45678901', '2021-11-05'),
('Laura', 'Becker', 'laura.becker@berealty.de', '+49 30 56789012', '2023-09-01');

INSERT INTO clients (first_name, last_name, email, phone, client_type)
VALUES
('Emma', 'Johnson', 'emma.johnson@email.com', '+49 151 11111111', 'Buyer'),
('Liam', 'Brown', 'liam.brown@email.com', '+49 151 22222222', 'Tenant'),
('Olivia', 'Taylor', 'olivia.taylor@email.com', '+49 151 33333333', 'Buyer'),
('Noah', 'Wilson', 'noah.wilson@email.com', '+49 151 44444444', 'Tenant'),
('Mia', 'Anderson', 'mia.anderson@email.com', '+49 151 55555555', 'Buyer'),
('Lucas', 'Thomas', 'lucas.thomas@email.com', '+49 151 66666666', 'Tenant'),
('Sofia', 'Moore', 'sofia.moore@email.com', '+49 151 77777777', 'Buyer'),
('Ethan', 'Martin', 'ethan.martin@email.com', '+49 151 88888888', 'Tenant');

INSERT INTO properties
(address, city, property_type, listing_type, price, bedrooms, bathrooms, area_sqm, status, agent_id)
VALUES
('12 Friedrichstrasse', 'Berlin', 'Apartment', 'Sale', 450000.00, 2, 1, 72.50, 'Available', 1),
('45 Sonnenallee', 'Berlin', 'Apartment', 'Rent', 1650.00, 2, 1, 68.00, 'Available', 2),
('8 Kurfürstenstrasse', 'Berlin', 'Commercial', 'Sale', 850000.00, NULL, 2, 150.00, 'Available', 3),
('23 Karl-Marx-Allee', 'Berlin', 'Apartment', 'Rent', 2100.00, 3, 2, 95.00, 'Available', 4),
('67 Prenzlauer Allee', 'Berlin', 'Apartment', 'Sale', 620000.00, 3, 2, 88.00, 'Available', 5),
('15 Warschauer Strasse', 'Berlin', 'Apartment', 'Rent', 1400.00, 1, 1, 52.00, 'Available', 1),
('91 Kantstrasse', 'Berlin', 'Commercial', 'Rent', 3200.00, NULL, 1, 120.00, 'Available', 2),
('34 Tempelhofer Damm', 'Berlin', 'Apartment', 'Sale', 390000.00, 2, 1, 64.00, 'Available', 3),
('56 Schönhauser Allee', 'Berlin', 'Apartment', 'Rent', 1850.00, 2, 1, 70.00, 'Available', 4),
('102 Hauptstrasse', 'Berlin', 'Commercial', 'Sale', 1100000.00, NULL, 3, 210.00, 'Available', 5);

INSERT INTO transactions
(property_id, client_id, agent_id, transaction_type, transaction_date, amount, status)
VALUES
(1, 1, 1, 'Sale', '2026-01-15', 450000.00, 'Completed'),
(2, 2, 2, 'Rent', '2026-02-03', 1650.00, 'Completed'),
(3, 3, 3, 'Sale', '2026-03-20', 850000.00, 'Completed'),
(4, 4, 4, 'Rent', '2026-04-11', 2100.00, 'Pending'),
(5, 5, 5, 'Sale', '2026-05-18', 620000.00, 'Completed'),
(6, 6, 1, 'Rent', '2026-06-07', 1400.00, 'Completed'),
(7, 7, 2, 'Rent', '2026-07-22', 3200.00, 'Pending'),
(8, 8, 3, 'Sale', '2026-08-09', 390000.00, 'Completed'),
(9, 1, 4, 'Rent', '2026-08-25', 1850.00, 'Pending'),
(10, 2, 5, 'Sale', '2026-09-02', 1100000.00, 'Pending');

INSERT INTO property_views (property_id, client_id, view_date)
VALUES
(1, 2, '2026-01-05 10:30:00'),
(1, 3, '2026-01-08 14:15:00'),
(2, 4, '2026-01-20 11:00:00'),
(2, 6, '2026-02-01 16:45:00'),
(3, 5, '2026-02-15 09:30:00'),
(4, 1, '2026-03-05 13:20:00'),
(5, 7, '2026-03-18 15:00:00'),
(6, 8, '2026-04-02 12:10:00'),
(7, 3, '2026-05-10 17:30:00'),
(8, 2, '2026-06-12 10:45:00'),
(9, 5, '2026-07-03 14:00:00'),
(10, 1, '2026-08-20 11:30:00');