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
| https://purl.humanatlas.io/graph/ccf | 557125 |
| https://purl.humanatlas.io/graph/hra-lit | 3608171 |
| https://purl.humanatlas.io/vocab/uberon | 1111228 |

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
| http://id.nlm.nih.gov/mesh/vocab#TopicalDescriptor | 17264 |
| http://schema.org/Organization | 913 |
| http://schema.org/Periodical | 2896 |
| http://schema.org/Person | 300130 |
| http://schema.org/PublicationIssue | 36532 |
| http://schema.org/PublicationVolume | 22868 |
| http://schema.org/ScholarlyArticle | 68623 |

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
| http://id.nlm.nih.gov/mesh/D007668 | 42536 |
| http://id.nlm.nih.gov/mesh/D006801 | 27791 |
| http://id.nlm.nih.gov/mesh/D000818 | 20758 |
| http://id.nlm.nih.gov/mesh/D008297 | 19280 |
| http://id.nlm.nih.gov/mesh/D005260 | 13810 |
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
| http://id.nlm.nih.gov/mesh/D007668 | Kidney | 205420 |
| http://id.nlm.nih.gov/mesh/D006801 | Humans | 143411 |
| http://id.nlm.nih.gov/mesh/D008297 | Male | 110660 |
| http://id.nlm.nih.gov/mesh/D000818 | Animals | 104832 |
| http://id.nlm.nih.gov/mesh/D005260 | Female | 85319 |
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

#### Results ([View CSV File](reports/hra-lit-ad-hoc/mesh-label-publication-counts.csv))

| mesh | label | publication_count |
| :--- | :--- | :--- |
| http://id.nlm.nih.gov/mesh/D007668 | Kidney | 42536 |
| http://id.nlm.nih.gov/mesh/D006801 | Humans | 27791 |
| http://id.nlm.nih.gov/mesh/D000818 | Animals | 20758 |
| http://id.nlm.nih.gov/mesh/D008297 | Male | 19280 |
| http://id.nlm.nih.gov/mesh/D005260 | Female | 13810 |
| ... | ... | ... |


  