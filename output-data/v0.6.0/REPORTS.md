# Summary of Reports

  ## Table of Contents

* ad-hoc
  * [Predicates in named graphs in the db (named-graph-predicates)](#named-graph-predicates)
  * [Named graphs in the db (named-graphs)](#named-graphs)
* universe-ad-hoc
  * [pmids-per-mesh](#pmids-per-mesh)



### <a id="named-graph-predicates"></a>Predicates in named graphs in the db (named-graph-predicates)

All predicates in named graphs in the queried SPARQL database

<details>
  <summary>View Sparql Query</summary>

```sparql
#+ summary: Predicates in named graphs in the db
#+ description: All predicates in named graphs in the queried SPARQL database

SELECT ?graph ?predicate
WHERE {
  GRAPH ?graph {
    [] ?predicate [] .
  }
  hint:Query hint:analytic "true" .
}
GROUP BY ?graph ?predicate
ORDER BY ?graph ?predicate

```

([View Source](../../queries/ad-hoc/named-graph-predicates.rq))
</details>

#### Results ([View CSV File](reports/ad-hoc/named-graph-predicates.csv))

| graph | predicate |
| :--- | :--- |
| http://id.nlm.nih.gov/mesh/ | http://id.nlm.nih.gov/mesh/vocab#Concept |
| http://id.nlm.nih.gov/mesh/ | http://id.nlm.nih.gov/mesh/vocab#abbreviation |
| http://id.nlm.nih.gov/mesh/ | http://id.nlm.nih.gov/mesh/vocab#active |
| http://id.nlm.nih.gov/mesh/ | http://id.nlm.nih.gov/mesh/vocab#allowableQualifier |
| http://id.nlm.nih.gov/mesh/ | http://id.nlm.nih.gov/mesh/vocab#altLabel |
| ... | ... |

## ad-hoc

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

([View Source](../../queries/ad-hoc/named-graphs.rq))
</details>

#### Results ([View CSV File](reports/ad-hoc/named-graphs.csv))

| graph | triples |
| :--- | :--- |
| http://id.nlm.nih.gov/mesh/ | 18334034 |
| https://purl.humanatlas.io/graph/ccf | 557125 |
| https://purl.humanatlas.io/graph/hra-lit-universe | 190843603 |


### <a id="pmids-per-mesh"></a>pmids-per-mesh



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX schema: <http://schema.org/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX MESH: <http://id.nlm.nih.gov/mesh/>
PREFIX HRAlitUniverse: <https://purl.humanatlas.io/graph/hra-lit-universe>

SELECT ?mesh (SAMPLE(?mesh_label) as ?mesh_label) (COUNT(?pmid) as ?pmid_count)
FROM MESH:
FROM HRAlitUniverse:
WHERE {
  ?mesh rdfs:label ?mesh_label .
  ?pmid schema:about ?mesh .
  hint:Query hint:analytic "true" .
}
GROUP BY ?mesh
ORDER BY DESC(?pmid_count)

```

([View Source](../../queries/universe-ad-hoc/pmids-per-mesh.rq))
</details>

#### Results ([View CSV File](reports/universe-ad-hoc/pmids-per-mesh.csv))

| mesh | mesh_label | pmid_count |
| :--- | :--- | :--- |
| http://id.nlm.nih.gov/mesh/D006801 | Humans | 8681329 |
| http://id.nlm.nih.gov/mesh/D005260 | Female | 3985411 |
| http://id.nlm.nih.gov/mesh/D008297 | Male | 3766671 |
| http://id.nlm.nih.gov/mesh/D000818 | Animals | 2586618 |
| http://id.nlm.nih.gov/mesh/D000328 | Adult | 2061201 |
| ... | ... | ... |

## universe-ad-hoc

  