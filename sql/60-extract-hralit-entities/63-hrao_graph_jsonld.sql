WITH
  ORGS AS (
    SELECT
      *
    FROM
      hrao
  )
SELECT
  JSONB_STRIP_NULLS(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM
  ORGS AS ROW;