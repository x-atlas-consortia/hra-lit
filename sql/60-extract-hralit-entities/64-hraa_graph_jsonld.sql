WITH PUBS AS (
	SELECT *
	FROM hraa
)
SELECT jsonb_strip_nulls(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM PUBS AS ROW; 