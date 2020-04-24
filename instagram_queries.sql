-- Find 5 Oldest Users --
SELECT username, created_at
FROM users
ORDER BY created_at LIMIT 5;

-- Day of Week Most Users Register On --
SELECT 
    DAYNAME(created_at) AS Day,
    COUNT(*) AS Count
FROM users
GROUP BY Day
ORDER BY COUNT(created_at) DESC;

-- Users Who Have Never Posted A Photo --
SELECT 
    username,
    image_url
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.image_url IS NULL;

-- Most Liked Photo --
SELECT
    users.username,
    likes.photo_id,
    photos.image_url,
    COUNT(*) AS total
FROM likes
JOIN photos
    ON photos.id = likes.photo_id
JOIN users
    ON users.id = photos.user_id
GROUP BY photo_id
ORDER BY total DESC 
LIMIT 1;

-- Average Posts Per User --
SELECT
    (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users);
    
-- TOP 5 Used Hashtags --
SELECT 
   tag_name,
   COUNT(tag_id) AS total
FROM tags 
JOIN photo_tags 
    ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC 
LIMIT 5;


-- FIND User that has Liked Every Photo --
 //does a photo have a like, if yes then does the same user show in that pile of likes 
 
 SELECT 
    username,
    COUNT(*) AS 'number of photos liked',
    CASE 
        WHEN COUNT(*) = (SELECT COUNT(*) FROM photos) THEN 'BOT'
        ELSE 'HUMAN'
     END AS 'Legit?'
FROM likes
JOIN users
    ON users.id = likes.user_id
GROUP BY likes.user_id
ORDER BY COUNT(likes.user_id);

-- *** ALTERNATIVE ***  Using the HAVING statement *** --
SELECT
    username,
    COUNT(*) AS num_liked
FROM users
JOIN likes
    ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_liked = (SELECT COUNT(*) FROM photos);


    