WITH
  PUBS AS (
    SELECT
      *
    FROM
      hram
  )
SELECT
  JSONB_STRIP_NULLS(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM
  PUBS AS ROW;