# Summary of Reports

  ## Table of Contents

* ad-hoc
  * [Named graphs in the db (named-graphs)](#named-graphs)
* hra-lit-ad-hoc
  * [class-counts](#class-counts)
  * [mesh-counts](#mesh-counts)
  * [mesh-label-author-counts](#mesh-label-author-counts)
  * [mesh-label-publication-counts](#mesh-label-publication-counts)



### <a id="named-graphs"></a>Named graphs in the db (named-graphs)

All named graphs in the queried SPARQL database

<details>
  <summary>View Sparql Query</summary>

```sparql
#+ summary: Named graphs in the db
#+ description: All named graphs in the queried SPARQL database

SELECT ?graph (COUNT(*) as ?triples) WHERE {
  GRAPH ?graph {
    ?s ?p ?o .
  }
}
GROUP BY ?graph
ORDER BY ?graph

```

([View Source](../../../reports/ad-hoc/named-graphs.rq))
</details>

#### Results ([View CSV File](reports/ad-hoc/named-graphs.csv))

| graph | triples |
| :--- | :--- |
| http://id.nlm.nih.gov/mesh/ | 18334034 |
| https://purl.humanatlas.io/collection/hra | 1920546 |
| https://purl.humanatlas.io/graph/ccf | 557123 |
| https://purl.humanatlas.io/graph/hra-lit | 289421773 |
| https://purl.humanatlas.io/vocab/uberon | 1152410 |

## ad-hoc

### <a id="class-counts"></a>class-counts



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX schema: <http://schema.org/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX MESH: <http://id.nlm.nih.gov/mesh/>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>

SELECT ?class (COUNT(*) as ?count)
FROM HRAlit:
WHERE {
  [] a ?class .
}
GROUP BY ?class
ORDER BY ?class

```

([View Source](../../../reports/hra-lit-ad-hoc/class-counts.rq))
</details>

#### Results ([View CSV File](reports/hra-lit-ad-hoc/class-counts.csv))

| class | count |
| :--- | :--- |
| http://id.nlm.nih.gov/mesh/vocab#TopicalDescriptor | 29716 |
| http://schema.org/Organization | 24213 |
| http://schema.org/Periodical | 13962 |
| http://schema.org/Person | 8706646 |
| http://schema.org/PublicationIssue | 1288160 |
| http://schema.org/PublicationVolume | 343800 |
| http://schema.org/ScholarlyArticle | 8780250 |

## hra-lit-ad-hoc

### <a id="mesh-counts"></a>mesh-counts



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX schema: <http://schema.org/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX MESH: <http://id.nlm.nih.gov/mesh/>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>

SELECT ?mesh (COUNT(*) as ?count)
FROM HRAlit:
WHERE {
  [] schema:about ?mesh .
}
GROUP BY ?mesh
ORDER BY DESC(?count)

```

([View Source](../../../reports/hra-lit-ad-hoc/mesh-counts.rq))
</details>

#### Results ([View CSV File](reports/hra-lit-ad-hoc/mesh-counts.csv))

| mesh | count |
| :--- | :--- |
| http://id.nlm.nih.gov/mesh/D006801 | 5679811 |
| http://id.nlm.nih.gov/mesh/D000818 | 3789979 |
| http://id.nlm.nih.gov/mesh/D008297 | 3482302 |
| http://id.nlm.nih.gov/mesh/D005260 | 3096888 |
| http://id.nlm.nih.gov/mesh/D000328 | 1659601 |
| ... | ... |


### <a id="mesh-label-author-counts"></a>mesh-label-author-counts



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX schema: <http://schema.org/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX MESH: <http://id.nlm.nih.gov/mesh/>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>

SELECT DISTINCT ?mesh ?label ?person
FROM HRAlit:
WHERE {
  [] a schema:ScholarlyArticle ;
    schema:about ?mesh ;
    schema:author ?person .
  ?mesh schema:name ?label .
}

```

([View Source](../../../reports/hra-lit-ad-hoc/mesh-label-author-counts.rq))
</details>

#### Results ([View CSV File](reports/hra-lit-ad-hoc/mesh-label-author-counts.csv))

| mesh | label | author_count |
| :--- | :--- | :--- |
| http://id.nlm.nih.gov/mesh/D006801 | Humans | 2130516 |
| http://id.nlm.nih.gov/mesh/D008297 | Male | 1563814 |
| http://id.nlm.nih.gov/mesh/D005260 | Female | 1476842 |
| http://id.nlm.nih.gov/mesh/D000818 | Animals | 1388551 |
| http://id.nlm.nih.gov/mesh/D000328 | Adult | 928976 |
| ... | ... | ... |


### <a id="mesh-label-publication-counts"></a>mesh-label-publication-counts



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX schema: <http://schema.org/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX MESH: <http://id.nlm.nih.gov/mesh/>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>

SELECT ?mesh (SAMPLE(?label) as ?label) (COUNT(DISTINCT(?publication)) as ?publication_count)
WHERE {
  GRAPH HRAlit: {
    ?publication a schema:ScholarlyArticle ;
      schema:about ?mesh .
    ?mesh schema:name ?label .
  }
}
GROUP BY ?mesh
ORDER BY DESC(?publication_count)

```

([View Source](../../../reports/hra-lit-ad-hoc/mesh-label-publication-counts.rq))
</details>

#### Columns
| mesh | label | publication_count |
| :--- | :--- | :--- |
| ... | ... | ... |

  