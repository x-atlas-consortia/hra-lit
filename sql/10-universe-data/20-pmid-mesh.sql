WITH CTE AS (
  SELECT 
    'https://identifiers.org/pubmed:' || H.pmid AS "@id",
    'http://id.nlm.nih.gov/mesh/' || ui AS "about",
    'MedicalScholarlyArticle' as "@type"
  FROM medline_mesh_heading H JOIN medline_master M ON (H.pmid = M.pmid)
  WHERE pub_year::integer > 2009
)
SELECT jsonb_strip_nulls(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM CTE AS ROW
