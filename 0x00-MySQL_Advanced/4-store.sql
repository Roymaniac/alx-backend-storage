DELIMITER //
CREATE TRIGGER decrease_item_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    -- Calculate the total quantity of items in the order
    DECLARE total_quantity INT;
    SELECT SUM(quantity) INTO total_quantity
    FROM orders
    WHERE item_id = NEW.item_id;

    -- Update the quantity of the corresponding item in the 'items' table
    UPDATE items
    SET quantity = quantity - total_quantity
    WHERE id = NEW.item_id;
END;
//
DELIMITER ;
