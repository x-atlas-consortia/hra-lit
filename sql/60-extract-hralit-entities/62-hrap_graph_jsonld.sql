WITH
  PERS AS (
    SELECT
      *
    FROM
      hrap
  )
SELECT
  JSONB_STRIP_NULLS(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM
  PERS AS ROW;