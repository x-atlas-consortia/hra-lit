WITH ORGS AS (
	 SELECT *
	 FROM hrao
)
SELECT jsonb_strip_nulls(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM ORGS AS ROW; 
