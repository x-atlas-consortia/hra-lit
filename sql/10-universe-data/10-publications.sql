WITH CTE AS (
  SELECT 
    'https://identifiers.org/pubmed:' || pmid AS "@id",
    'ScholarlyArticle' as "@type",
    'PMID:' || pmid AS identifier,
    article_title AS name,
    pub_year::integer AS "datePublished"
  FROM medline_master
  WHERE pub_year::integer > 2009
  ORDER BY pub_year DESC
)
SELECT jsonb_strip_nulls(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM CTE AS ROW
