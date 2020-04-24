# SELECT
# 	CONCAT
# 	(
# 		SUBSTRING(title, 1, 10),
# 		'...'
# 	) AS 'short-title'
# FROM books;

# SELECT 
# 	CHAR_LENGTH(
# 	SUBSTRING(
# 		REPLACE(title, 'e', 3), 1, 10
# 	)) AS 'title'
# FROM books;

# SELECT CONCAT(author_lname, ' is ', CHAR_LENGTH(author_lname), " characters long.") FROM books;
		
# SELECT CONCAT("MY FAVORITE BOOK IS ", SUBSTRING(UPPER(title), 1 ,20)) FROM books;

SELECT
	CONCAT
	(
		SUBSTRING(title, 1, 10),
		'...'
	) AS 'short title',
	CONCAT
	(
		author_lname, 
		', ', 
		author_fname
	) AS 'author',
	CONCAT
	(
		stock_quantity,
		' in stock'
	) AS 'quantity'
FROM books;