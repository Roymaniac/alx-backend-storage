-- List all bands with Glam rock as their main style and compute their longevity
SELECT band_name, 
       DATEDIFF('2022-01-01', DATE(split)) / 365 AS lifespan
FROM metal_bands
WHERE FIND_IN_SET('Glam rock', styles) > 0
ORDER BY lifespan DESC;
