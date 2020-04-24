CREATE TABLE users(
    email VARCHAR(255) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT NOW()
);

-- EARLIEST DATE USER JOINED --
SELECT 
    DATE(created_at) AS earliest_date    
FROM users
ORDER BY created_at
LIMIT 1;

-- FIND EMAIL OF FIRST USER --
SELECT
    email,
    created_at
FROM users
ORDER BY created_at 
LIMIT 1;

-- USERS ACCORDING TO MONTH JOINED --
SELECT 
    MONTHNAME(created_at) AS month,
    COUNT(*) AS count
FROM users
GROUP BY MONTH(created_at)
ORDER BY COUNT(*) DESC;

-- NUMBER OF YAHOO USERS --
SELECT 
    COUNT(*) AS yahoo_users
FROM users 
WHERE email LIKE '%@yahoo.com';

-- TOTAL NUMBER OF USERS PER HOST --
SELECT
    CASE 
        WHEN email LIKE '%@yahoo.com' THEN 'yahoo'
        WHEN email LIKE '%@gmail.com' THEN 'gmail'
        WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
        ELSE 'other'
    END AS provider,
    COUNT(*) AS total_users
FROM users
GROUP BY provider
ORDER BY COUNT(*) DESC;
    

