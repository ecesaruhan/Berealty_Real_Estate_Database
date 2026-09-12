SELECT
    property_id,
    address,
    city,
    property_type,
    listing_type,
    price,
    bedrooms,
    bathrooms,
    area_sqm,
    status
FROM properties
ORDER BY price DESC;

SELECT
    a.agent_id,
    CONCAT(a.first_name, ' ', a.last_name) AS agent_name,
    p.property_id,
    p.address,
    p.property_type,
    p.listing_type,
    p.price,
    p.status
FROM agents a
INNER JOIN properties p
    ON a.agent_id = p.agent_id
ORDER BY a.agent_id, p.property_id;

SELECT
    c.client_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    t.transaction_id,
    p.address,
    t.transaction_type,
    t.transaction_date,
    t.amount,
    t.status
FROM clients c
INNER JOIN transactions t
    ON c.client_id = t.client_id
INNER JOIN properties p
    ON t.property_id = p.property_id
ORDER BY t.transaction_date;

-- 4. List all agents and the number of transactions they handled
SELECT
    a.agent_id,
    CONCAT(a.first_name, ' ', a.last_name) AS agent_name,
    COUNT(t.transaction_id) AS transaction_count
FROM agents a
LEFT JOIN transactions t
    ON a.agent_id = t.agent_id
GROUP BY
    a.agent_id,
    a.first_name,
    a.last_name
ORDER BY transaction_count DESC;

-- 5. List all transactions with client and property details
SELECT
    t.transaction_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    p.address,
    t.transaction_type,
    t.transaction_date,
    t.amount,
    t.status
FROM transactions t
INNER JOIN clients c
    ON t.client_id = c.client_id
INNER JOIN properties p
    ON t.property_id = p.property_id
ORDER BY t.transaction_date;

-- 6. Show all agents and their transactions
SELECT
    a.agent_id,
    CONCAT(a.first_name, ' ', a.last_name) AS agent_name,
    t.transaction_id,
    t.transaction_type,
    t.transaction_date,
    t.amount,
    t.status
FROM agents a
LEFT JOIN transactions t
    ON a.agent_id = t.agent_id
ORDER BY a.agent_id;

-- 7. Show all transactions and responsible agents (RIGHT JOIN)
-- Displays all agents, including agents who may not yet have completed any transactions.
SELECT
    a.agent_id,
    CONCAT(a.first_name, ' ', a.last_name) AS agent_name,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.status
FROM transactions t
RIGHT JOIN agents a
    ON t.agent_id = a.agent_id
ORDER BY a.agent_id;

-- 8. Show possible combinations of agents and properties (CROSS JOIN)
-- Purpose: To demonstrate all possible combinations between agents and properties.
SELECT
    a.agent_id,
    CONCAT(a.first_name, ' ', a.last_name) AS agent_name,
    p.property_id,
    p.address,
    p.property_type
FROM agents a
CROSS JOIN properties p
ORDER BY a.agent_id, p.property_id;

-- 9. Monthly transaction report
-- Purpose: To summarise the number of transactions and total transaction value for each month.
SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS transaction_month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY transaction_month;

-- 10. Quarterly transaction report
-- Purpose: To summarise transactions by quarter and show the total transaction value.
SELECT
    YEAR(transaction_date) AS transaction_year,
    QUARTER(transaction_date) AS transaction_quarter,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY
    YEAR(transaction_date),
    QUARTER(transaction_date)
ORDER BY
    transaction_year,
    transaction_quarter;
    
-- 11. Yearly transaction report
-- Purpose: To summarise the total number and value of transactions for each year.
SELECT
    YEAR(transaction_date) AS transaction_year,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY YEAR(transaction_date)
ORDER BY transaction_year;

-- 12. Agent transaction summary
-- Purpose: To compare agents based on the number and total value of their transactions.
SELECT
    a.agent_id,
    CONCAT(a.first_name, ' ', a.last_name) AS agent_name,
    COUNT(t.transaction_id) AS total_transactions,
    COALESCE(SUM(t.amount), 0) AS total_amount
FROM agents a
LEFT JOIN transactions t
    ON a.agent_id = t.agent_id
GROUP BY
    a.agent_id,
    a.first_name,
    a.last_name
ORDER BY total_amount DESC;

-- 13. Client transaction summary
-- Purpose: To compare clients based on the number and total value of their transactions.
SELECT
    c.client_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    COUNT(t.transaction_id) AS total_transactions,
    COALESCE(SUM(t.amount), 0) AS total_amount
FROM clients c
LEFT JOIN transactions t
    ON c.client_id = t.client_id
GROUP BY
    c.client_id,
    c.first_name,
    c.last_name
ORDER BY total_amount DESC;

-- 14. Property status summary
-- Purpose: To show how many properties are available or unavailable for management purposes.
SELECT
    status,
    COUNT(*) AS total_properties
FROM properties
GROUP BY status
ORDER BY total_properties DESC;

-- 15. Property type summary
-- Purpose: To analyse the number and average price of properties by property type.
SELECT
    property_type,
    COUNT(*) AS total_properties,
    AVG(price) AS average_price
FROM properties
GROUP BY property_type
ORDER BY total_properties DESC;

-- 16. Properties with transactions above the average transaction amount
-- Purpose: To identify properties involved in transactions whose value is above
-- the overall average transaction amount.
SELECT
    p.property_id,
    p.address,
    p.property_type,
    t.transaction_id,
    t.amount,
    t.transaction_type
FROM properties p
INNER JOIN transactions t
    ON p.property_id = t.property_id
WHERE t.amount > (
    SELECT AVG(amount)
    FROM transactions
)
ORDER BY t.amount DESC;


-- Trigger test
INSERT INTO transactions
(property_id, client_id, agent_id, transaction_type, transaction_date, amount, status)
VALUES
(6, 1, 1, 'Sale', '2026-09-12', 400000.00, 'Completed');

SELECT property_id, address, status
FROM properties
WHERE property_id = 6;

-- Remove trigger test data
DELETE FROM transactions
WHERE property_id = 6
  AND transaction_date = '2026-09-12'
  AND amount = 400000.00;

UPDATE properties
SET status = 'Available'
WHERE property_id = 6;