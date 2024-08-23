WITH
  CTE AS (
    SELECT
      'https://identifiers.org/pubmed:' || pmid AS "@id",
      'ScholarlyArticle' AS "@type",
      'PMID:' || pmid AS identifier,
      article_title AS NAME,
      pub_year::INTEGER AS "datePublished"
    FROM
      medline_master
    WHERE
      pub_year::INTEGER > 2009
    ORDER BY
      pub_year DESC
  )
SELECT
  JSONB_STRIP_NULLS(ROW_TO_JSON(ROW)::jsonb) AS json_data
FROM
  CTE AS ROW