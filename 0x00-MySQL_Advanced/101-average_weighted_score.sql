DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    -- Declare variables to hold the computed weighted average score
    DECLARE user_id INT;
    DECLARE total_weighted_score DECIMAL(10, 2);
    DECLARE total_weight DECIMAL(10, 2);
    
    -- Declare a cursor to loop through all user IDs
    DECLARE user_cursor CURSOR FOR
    SELECT id FROM users;
    
    -- Cursor variables
    DECLARE done INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Open the cursor and start looping through user IDs
    OPEN user_cursor;
    loop_users: LOOP
        FETCH user_cursor INTO user_id;
        IF done = 1 THEN
            LEAVE loop_users;
        END IF;
        
        -- Calculate the total weighted score and total weight for the current user
        SELECT SUM(score * weight) INTO total_weighted_score, SUM(weight) INTO total_weight
        FROM scores
        WHERE user_id = user_id;
        
        -- Calculate the average weighted score
        DECLARE avg_weighted_score DECIMAL(10, 2);
        IF total_weight > 0 THEN
            SET avg_weighted_score = total_weighted_score / total_weight;
        ELSE
            SET avg_weighted_score = 0;
        END IF;
        
        -- Update the user's average weighted score in the users table
        UPDATE users
        SET average_weighted_score = avg_weighted_score
        WHERE id = user_id;
    END LOOP;
    
    -- Close the cursor
    CLOSE user_cursor;
    
    SELECT 'Average weighted scores computed and stored for all users' AS message;
END;
//
DELIMITER ;
