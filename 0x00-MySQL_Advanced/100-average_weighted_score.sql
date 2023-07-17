DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(
    IN p_user_id INT
)
BEGIN
    -- Declare variables to hold the computed weighted average score
    DECLARE total_weighted_score DECIMAL(10, 2);
    DECLARE total_weight DECIMAL(10, 2);
    
    -- Calculate the total weighted score and total weight
    SELECT SUM(score * weight) INTO total_weighted_score, SUM(weight) INTO total_weight
    FROM scores
    WHERE user_id = p_user_id;
    
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
    WHERE id = p_user_id;
    
    SELECT CONCAT('Average weighted score computed and stored for user_id ', p_user_id, ': ', avg_weighted_score) AS message;
END;
//
DELIMITER ;
