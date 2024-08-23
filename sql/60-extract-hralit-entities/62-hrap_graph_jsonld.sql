WITH PERS AS (
	SELECT * 
	FROM hrap
)
SELECT jsonb_strip_nulls(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM PERS AS ROW; 
