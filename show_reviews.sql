-- SCHEMA --
CREATE TABLE reviewers(
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE series(
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    released_year YEAR(4),
    genre VARCHAR(100)
);

CREATE TABLE reviews(
    id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(2, 1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);

SELECT 
    title,
    rating 
FROM series
    INNER JOIN reviews
        ON series.id = reviews.series_id;
        
SELECT
    title,
    AVG(rating) AS avg_rating
FROM series
    INNER JOIN reviews
        ON series.id = reviews.series_id
GROUP BY series.id
ORDER BY avg_rating DESC;

SELECT
    first_name,
    last_name,
    rating
FROM reviewers
    INNER JOIN reviews
        ON reviewers.id = reviews.reviewer_id;
        
SELECT
    title AS unreviewed_series
FROM series
   LEFT JOIN reviews
        ON series.id = reviews.series_id
WHERE rating IS NULL;
        
SELECT
    genre,
    AVG(rating) AS avg_rating
FROM series
    INNER JOIN reviews
        ON series.id = reviews.series_id
GROUP BY genre;

SELECT
    genre,
    ROUND(
        AVG(rating), 2)
        AS avg_rating
FROM series
    INNER JOIN reviews
        ON series.id = reviews.series_id
GROUP BY genre;

SELECT 
    first_name,
    last_name,
    COUNT(rating) AS COUNT,
    MIN(rating) AS MIN,
    MAX(rating) AS MAX,
    ROUND(
        AVG(rating), 2
        ) AS AVG,
    IF(COUNT(rating) >= 1, 'ACTIVE', 'INACTIVE') AS STATUS
FROM reviewers
    LEFT JOIN reviews
        ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;

-- JOIN ALL THREE TABLES --

SELECT 
    title,
    rating,
    CONCAT(first_name, ' ', last_name) AS reviewer
FROM reviewers
    JOIN reviews
        ON reviewers.id = reviews.reviewer_id
    JOIN series
        ON series.id = reviews.series_id
ORDER BY title;

    