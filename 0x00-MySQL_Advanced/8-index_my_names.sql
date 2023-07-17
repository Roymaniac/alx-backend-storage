-- Create the index idx_name_first
CREATE INDEX idx_name_first
ON names (SUBSTRING(name, 1, 1));
