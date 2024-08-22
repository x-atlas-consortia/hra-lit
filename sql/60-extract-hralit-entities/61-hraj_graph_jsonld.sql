WITH PERI AS (
	SELECT * 
	FROM public.hraj
)
SELECT jsonb_strip_nulls(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM PERI AS ROW  
