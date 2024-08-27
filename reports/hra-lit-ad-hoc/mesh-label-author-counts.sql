.mode csv
SELECT
  mesh,
  FIRST(label) AS label,
  COUNT(DISTINCT person) AS author_count
FROM
  read_csv ('/dev/stdin')
GROUP BY
  mesh
ORDER BY
  author_count DESC