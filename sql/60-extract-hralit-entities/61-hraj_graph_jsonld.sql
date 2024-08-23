WITH
  PERI AS (
    SELECT
      *
    FROM
      hraj
  )
SELECT
  JSONB_STRIP_NULLS(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM
  PERI AS ROW