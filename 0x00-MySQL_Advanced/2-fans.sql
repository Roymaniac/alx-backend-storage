-- Create a temporary table to store the rankings
CREATE TEMPORARY TABLE IF NOT EXISTS temp_rankings AS
SELECT origin, COUNT(*) AS nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;

-- Rank the origins based on the number of fans
SELECT origin, nb_fans
FROM temp_rankings;
