DELIMITER //
CREATE PROCEDURE AddBonus(
    IN p_user_id INT,
    IN p_project_name VARCHAR(255),
    IN p_score DECIMAL(10, 2)
)
BEGIN
    -- Check if the project exists, if not, create it
    DECLARE project_id INT;
    
    SELECT id INTO project_id
    FROM projects
    WHERE name = p_project_name;
    
    IF project_id IS NULL THEN
        INSERT INTO projects (name) VALUES (p_project_name);
        SET project_id = LAST_INSERT_ID();
    END IF;
    
    -- Add the correction for the student
    INSERT INTO corrections (user_id, project_id, score)
    VALUES (p_user_id, project_id, p_score);
    
    SELECT CONCAT('Correction added for user_id ', p_user_id, ' and project_name ', p_project_name, '. Score: ', p_score) AS message;
END;
//
DELIMITER ;
