USE berealty;

CREATE TABLE agents (
    agent_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE
);

CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    client_type VARCHAR(20) NOT NULL
);

CREATE TABLE properties (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    property_type VARCHAR(50) NOT NULL,
    listing_type VARCHAR(20) NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    bedrooms INT,
    bathrooms INT,
    area_sqm DECIMAL(8,2),
    status VARCHAR(20) NOT NULL,
    agent_id INT,
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    client_id INT NOT NULL,
    agent_id INT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    transaction_date DATE NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

CREATE TABLE property_views (
    view_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    client_id INT NOT NULL,
    view_date DATETIME NOT NULL,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

DELIMITER //

CREATE TRIGGER update_property_status
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    IF NEW.status = 'Completed' THEN
        UPDATE properties
        SET status = 'Sold'
        WHERE property_id = NEW.property_id
        AND NEW.transaction_type = 'Sale';
    END IF;
END //

DELIMITER ;