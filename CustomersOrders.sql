CREATE TABLE customers(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(100)
);

CREATE TABLE orders(
	id INT AUTO_INCREMENT PRIMARY KEY,
	order_date DATE,
	amount DECIMAL(8,2),
	customer_id INT,
	FOREIGN KEY(customer_id) REFERENCES customers(id)
);	

-- Implicit less conventional
SELECT * FROM orders WHERE customer_id = (
	SElECT id FROM customers
	WHERE last_name = "George"
);

SELECT * FROM customers, orders WHERE customers.id = orders.customer_id;

-- Explicit more conventional
SELECT  first_name, order_date, amount FROM customers JOIN orders
	ON customers.id = orders.customer_id;
    
-- Getting Fancier --
SELECT
    first_name,
    last_name,
    order_date,
    SUM(amount) AS total_spent
    FROM customers
    JOIN orders
    ON customers.id = orders.customer_id
    GROUP BY orders.customer_id
    ORDER BY total_spent DESC;
    
-- LEFT JOIN --
SELECT * FROM customers
LEFT JOIN orders
    on customers.id = orders.customer_id;
    
SELECT first_name,
        last_name,
        IFNULL(SUM(amount), 0) AS total_spent
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;

-- RIGHT JOIN --
SELECT * FROM customers
    RIGHT JOIN orders
    ON customers.id = orders.customer_id;

-- ON DELETE CASCADE --
CREATE TABLE orders(
	id INT AUTO_INCREMENT PRIMARY KEY,
	order_date DATE,
	amount DECIMAL(8,2),
	customer_id INT,
	FOREIGN KEY(customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE
);	

-- JOIN EXERCISES --

-- SCHEMA --
CREATE TABLE students(
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100)
);

CREATE TABLE papers(
    title VARCHAR(100),
    grade DECIMAL(3, 1),
    student_id INT, 
    FOREIGN KEY (student_id)
        REFERENCES students(id)
);

INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT first_name, title, grade
    FROM students
    JOIN papers
    ON students.id = papers.student_id
ORDER BY grade DESC;
    
SELECT first_name, title, grade
    FROM students
    LEFT JOIN papers
    ON students.id = papers.student_id;

SELECT 
    first_name,
    IFNULL(title, 'MISSING') AS title,
    IFNULL(grade, 0) AS grade
    FROM students
    LEFT JOIN papers
    ON students.id = papers.student_id;
    
SELECT 
    first_name,
    IFNULL(AVG(grade), 0) AS average
    FROM students
    LEFT JOIN papers
    ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;

SELECT 
    first_name,
    IFNULL(AVG(grade), 0) AS average,
    CASE
        WHEN IFNULL(AVG(grade), 0) < 75 THEN 'FAILING'
        ELSE 'PASSING'
        END AS passing_status
    FROM students
    LEFT JOIN papers
    ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;
