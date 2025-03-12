WITH
  CTE AS (
    SELECT
      'https://identifiers.org/pubmed:' || H.pmid AS "@id",
      'http://id.nlm.nih.gov/mesh/' || ui AS "about",
      'ScholarlyArticle' AS "@type"
    FROM
      medline_mesh_heading H
      JOIN medline_master M ON (H.pmid = M.pmid)
  )
SELECT
  JSONB_STRIP_NULLS(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM
  CTE AS ROW