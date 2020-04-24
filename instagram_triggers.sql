# DELIMITER $$

# CREATE TRIGGER prevent_self_follow
#     BEFORE INSERT ON follows FOR EACH ROW
#     BEGIN
#         IF NEW.follower_id = NEW.followee_id
#         THEN
#             SIGNAL SQLSTATE '45000'
#                 SET MESSAGE_TEXT = 'Cannot follow yourself!';
#         END IF;
#     END;
# $$

# DELIMITER ;


DELIMITER $$

CREATE TRIGGER log_unfollows
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        # INSERT INTO unfollows (follower_id, followee_id)
        # VALUES (OLD.follower_id, OLD.followee_id)
        INSERT INTO unfollows
        SET 
            follower_id = OLD.follower_id,
            followee_id = OLD.followee_id;
    END;
$$

DELIMITER ;