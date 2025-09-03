# Summary of Reports

  ## Table of Contents

* ad-hoc
  * [Named graphs in the db (named-graphs)](#named-graphs)
* hra-lit-ad-hoc
  * [class-counts](#class-counts)
  * [mesh-counts](#mesh-counts)
  * [mesh-label-author-counts](#mesh-label-author-counts)
  * [mesh-label-publication-counts](#mesh-label-publication-counts)
* hra-lit-kidney
  * [hra-lit-kidney-as-nodes](#hra-lit-kidney-as-nodes)
  * [hra-lit-kidney-disease-nodes](#hra-lit-kidney-disease-nodes)
  * [hra-lit-kidney-diseases-cooccur-edges](#hra-lit-kidney-diseases-cooccur-edges)
* hra-lit-validations
  * [hralit-MeSH_concept-cooccurence-edgeList](#hralit-MeSH_concept-cooccurence-edgeList)
  * [hralit-MeSH_concept-cooccurence-nodeList](#hralit-MeSH_concept-cooccurence-nodeList)
  * [hralit-MeSH_subject_annual_publications](#hralit-MeSH_subject_annual_publications)
  * [hralit-OBO_subject_annual_publications](#hralit-OBO_subject_annual_publications)
  * [hralit-author_person+article_id-lists+year](#hralit-author_person+article_id-lists+year)
  * [hralit-expert_identification-organizations](#hralit-expert_identification-organizations)
  * [hralit-expert_identification-persons](#hralit-expert_identification-persons)
  * [hralit-journal_annual_publications](#hralit-journal_annual_publications)
  * [hralit-meshDescriptor-publicationCountDistinct](#hralit-meshDescriptor-publicationCountDistinct)
  * [hralit-publication-mesh-search](#hralit-publication-mesh-search)
  * [hralit-sssom-MeSH-pubCounts](#hralit-sssom-MeSH-pubCounts)
  * [hralit-subject+journal_annual_publications](#hralit-subject+journal_annual_publications)



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

### <a id="hra-lit-kidney-as-nodes"></a>hra-lit-kidney-as-nodes



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/UBERON_>
PREFIX cl: <http://purl.obolibrary.org/obo/CL_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX ccf: <http://purl.org/ccf/>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX HRA: <https://purl.humanatlas.io/collection/hra>
PREFIX UBERON: <https://purl.humanatlas.io/vocab/uberon>
PREFIX MESH_MAPPING: <https://purl.humanatlas.io/graph/mesh-uberon-cl-human-mapping>

SELECT DISTINCT ?iri (SAMPLE(?label) as ?label) (SAMPLE(?type) as ?type) (HRAlit: as ?source)
WHERE {
  # Identify set of MeSH descriptors related to Kidney
  GRAPH mesh: {
    mesh:D007668 meshv:treeNumber ?treeNum .
    ?childTreeNum meshv:parentTreeNumber* ?treeNum .
    ?searchDescriptor meshv:treeNumber ?childTreeNum ;
      meshv:preferredConcept ?term .
  }
  GRAPH MESH_MAPPING: {
    ?term skos:exactMatch ?iri .
  }
  GRAPH UBERON: {
    ?iri rdfs:label ?label .
  }
  BIND(IF(STRSTARTS(STR(?iri), STR(uberon:)), 
    <http://purl.obolibrary.org/obo/UBERON_0000061>, #AS
    <http://purl.obolibrary.org/obo/CL_0000000>) #CT
    AS ?type)
}
GROUP BY ?iri
ORDER BY ?iri

```

([View Source](../../../reports/hra-lit-kidney/hra-lit-kidney-as-nodes.rq))
</details>

#### Results ([View CSV File](reports/hra-lit-kidney/hra-lit-kidney-as-nodes.csv))

| iri | label | type | source |
| :--- | :--- | :--- | :--- |
| http://purl.obolibrary.org/obo/CL_0000650 | mesangial cell | http://purl.obolibrary.org/obo/CL_0000000 | https://purl.humanatlas.io/graph/hra-lit |
| http://purl.obolibrary.org/obo/CL_0000653 | podocyte | http://purl.obolibrary.org/obo/CL_0000000 | https://purl.humanatlas.io/graph/hra-lit |
| http://purl.obolibrary.org/obo/UBERON_0000074 | renal glomerulus | http://purl.obolibrary.org/obo/UBERON_0000061 | https://purl.humanatlas.io/graph/hra-lit |
| http://purl.obolibrary.org/obo/UBERON_0000362 | renal medulla | http://purl.obolibrary.org/obo/UBERON_0000061 | https://purl.humanatlas.io/graph/hra-lit |
| http://purl.obolibrary.org/obo/UBERON_0001224 | renal pelvis | http://purl.obolibrary.org/obo/UBERON_0000061 | https://purl.humanatlas.io/graph/hra-lit |
| ... | ... | ... | ... |

## hra-lit-kidney

### <a id="hra-lit-kidney-disease-nodes"></a>hra-lit-kidney-disease-nodes



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/UBERON_>
PREFIX cl: <http://purl.obolibrary.org/obo/CL_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX ccf: <http://purl.org/ccf/>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX HRA: <https://purl.humanatlas.io/collection/hra>
PREFIX UBERON: <https://purl.humanatlas.io/vocab/uberon>
PREFIX MESH_MAPPING: <https://purl.humanatlas.io/graph/mesh-uberon-cl-human-mapping>

SELECT DISTINCT ?iri (SAMPLE(?label) as ?label) (mesh:D007674 as ?type) (HRAlit: as ?source)
WHERE {
  # Identify set of MeSH descriptors related to Kidney Diseases
  GRAPH mesh: {
    mesh:D007674 meshv:treeNumber ?treeNum .
    ?childTreeNum meshv:parentTreeNumber* ?treeNum .
    ?iri meshv:treeNumber ?childTreeNum ;
      meshv:preferredConcept ?term .
    ?iri rdfs:label ?label .
  }
}
GROUP BY ?iri
ORDER BY ?iri

```

([View Source](../../../reports/hra-lit-kidney/hra-lit-kidney-disease-nodes.rq))
</details>

#### Results ([View CSV File](reports/hra-lit-kidney/hra-lit-kidney-disease-nodes.csv))

| iri | label | type | source |
| :--- | :--- | :--- | :--- |
| http://id.nlm.nih.gov/mesh/D000069856 | Staghorn Calculi | http://id.nlm.nih.gov/mesh/D007674 | https://purl.humanatlas.io/graph/hra-lit |
| http://id.nlm.nih.gov/mesh/D000092702 | Chronic Kidney Diseases of Uncertain Etiology | http://id.nlm.nih.gov/mesh/D007674 | https://purl.humanatlas.io/graph/hra-lit |
| http://id.nlm.nih.gov/mesh/D000141 | Acidosis, Renal Tubular | http://id.nlm.nih.gov/mesh/D007674 | https://purl.humanatlas.io/graph/hra-lit |
| http://id.nlm.nih.gov/mesh/D000608 | Renal Aminoacidurias | http://id.nlm.nih.gov/mesh/D007674 | https://purl.humanatlas.io/graph/hra-lit |
| http://id.nlm.nih.gov/mesh/D001002 | Anuria | http://id.nlm.nih.gov/mesh/D007674 | https://purl.humanatlas.io/graph/hra-lit |
| ... | ... | ... | ... |


### <a id="hra-lit-kidney-diseases-cooccur-edges"></a>hra-lit-kidney-diseases-cooccur-edges



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/UBERON_>
PREFIX cl: <http://purl.obolibrary.org/obo/CL_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX ccf: <http://purl.org/ccf/>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX HRA: <https://purl.humanatlas.io/collection/hra>
PREFIX UBERON: <https://purl.humanatlas.io/vocab/uberon>
PREFIX MESH_MAPPING: <https://purl.humanatlas.io/graph/mesh-uberon-cl-human-mapping>

SELECT DISTINCT ?subject (<https://purl.humanatlas.io/graph/hra-lit#COOCCURS_WITH_DISEASE> as ?predicate) ?object (COUNT(DISTINCT(?article)) AS ?pub_count)
WHERE {
  # Identify set of MeSH descriptors related to Kidney
  GRAPH mesh: {
    mesh:D007668 meshv:treeNumber ?treeNum .
    ?childTreeNum meshv:parentTreeNumber* ?treeNum .
    ?kidneyDescriptor meshv:treeNumber ?childTreeNum ;
      meshv:preferredConcept ?term .
  }
  GRAPH MESH_MAPPING: {
    ?term skos:exactMatch ?subject .
  }

  # Identify set of MeSH descriptors related to Kidney Diseases
  GRAPH mesh: {
    mesh:D007674 meshv:treeNumber ?treeNum2 .
    ?childTreeNum2 meshv:parentTreeNumber* ?treeNum2 .
    ?object meshv:treeNumber ?childTreeNum2 ;
      meshv:preferredConcept ?disease .

    ?disease rdfs:label ?disease_label .
  }

  GRAPH HRAlit: {
    ?article schema:about ?kidneyDescriptor ;
      schema:about ?object .
  }
}
GROUP BY ?subject ?object
ORDER BY DESC(?pub_count)

```

([View Source](../../../reports/hra-lit-kidney/hra-lit-kidney-diseases-cooccur-edges.rq))
</details>

#### Results ([View CSV File](reports/hra-lit-kidney/hra-lit-kidney-diseases-cooccur-edges.csv))

| subject | predicate | object | pub_count |
| :--- | :--- | :--- | :--- |
| http://purl.obolibrary.org/obo/UBERON_0002113 | https://purl.humanatlas.io/graph/hra-lit#COOCCURS_WITH_DISEASE | http://id.nlm.nih.gov/mesh/D007674 | 23376 |
| http://purl.obolibrary.org/obo/UBERON_0002113 | https://purl.humanatlas.io/graph/hra-lit#COOCCURS_WITH_DISEASE | http://id.nlm.nih.gov/mesh/D058186 | 10827 |
| http://purl.obolibrary.org/obo/UBERON_0002113 | https://purl.humanatlas.io/graph/hra-lit#COOCCURS_WITH_DISEASE | http://id.nlm.nih.gov/mesh/D007680 | 10025 |
| http://purl.obolibrary.org/obo/UBERON_0002113 | https://purl.humanatlas.io/graph/hra-lit#COOCCURS_WITH_DISEASE | http://id.nlm.nih.gov/mesh/D007676 | 7004 |
| http://purl.obolibrary.org/obo/UBERON_0002113 | https://purl.humanatlas.io/graph/hra-lit#COOCCURS_WITH_DISEASE | http://id.nlm.nih.gov/mesh/D051436 | 6355 |
| ... | ... | ... | ... |


### <a id="hralit-MeSH_concept-cooccurence-edgeList"></a>hralit-MeSH_concept-cooccurence-edgeList



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT ?meshDescriptor1 
       ?meshDescriptor2
       (COUNT(?article) as ?articleCount)
FROM HRAlit: 
WHERE {
  # Query hints to speed up processing
  hint:Query hint:optimizer "Runtime" .

  # Subquery to find qualifying articles first
  { 
    SELECT DISTINCT ?article 
    WHERE {
      hint:SubQuery hint:runOnce "true" .
      ?article schema:about mesh:D007668 ;
                schema:about mesh:D020869 ;
                schema:about mesh:D006801 ;
                schema:datePublished ?datePublished .
      BIND(xsd:integer(
                IF(CONTAINS(?datePublished, "-"),
                    STRBEFORE(?datePublished, "-"),
                    IF(STRLEN(STR(?datePublished)) >= 4,
                        SUBSTR(STR(?datePublished), 1, 4),
                        STR(?datePublished)
                    )
                    )  
              ) AS ?year
            )   
      FILTER(?year <= 2024 && ?year >= 1999)
    }
  }
  
  {
    # Generate co-occurence network- using an out-star network pattern.
    ?article schema:about ?md1 ;
             schema:about ?md2 .

    BIND(IF(STR(?md1) < STR(?md2), ?md1, ?md2) as ?meshDescriptor1)
    BIND(IF(STR(?md1) < STR(?md2), ?md2, ?md1) as ?meshDescriptor2)
    
    FILTER(?md1 != ?md2)
  }
}
GROUP BY ?meshDescriptor1 ?meshDescriptor2
HAVING (?articleCount >= 1)
ORDER BY DESC(?articleCount)

```

([View Source](../../../reports/hra-lit-validations/hralit-MeSH_concept-cooccurence-edgeList.rq))
</details>

#### Columns
| meshDescriptor1 | meshDescriptor2 | articleCount |
| :--- | :--- | :--- |
| ... | ... | ... |
## hra-lit-validations

### <a id="hralit-MeSH_concept-cooccurence-nodeList"></a>hralit-MeSH_concept-cooccurence-nodeList



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT ?meshDescriptor
       (SAMPLE(?label) as ?label)
       (COUNT(DISTINCT ?article) as ?articleCount)
FROM HRAlit: 
FROM NAMED <http://id.nlm.nih.gov/mesh/>
WHERE {
  # Subquery to find qualifying articles first
  # Query hints to speed up processing
  hint:Query hint:optimizer "Runtime" .
  {
    SELECT DISTINCT ?article ?year WHERE {
    ?article schema:about mesh:D007668 ;   # Kidney
             schema:about mesh:D020869 ;   # Gene Expression Profiling  
             schema:about mesh:D006801 ;   # Human studies
             schema:datePublished ?datePublished .
      
    BIND(xsd:integer(
          IF(CONTAINS(?datePublished, "-"),
             STRBEFORE(?datePublished, "-"),
             IF(STRLEN(STR(?datePublished)) >= 4,
                SUBSTR(STR(?datePublished), 1, 4),
                STR(?datePublished)
               )
            )  
          ) AS ?year
        )   
      FILTER(?year <= 2024 && ?year >= 1999)
    }
  }
  ?article schema:about ?meshDescriptor .
  
  OPTIONAL{  
    # Get MeSH labels
    GRAPH <http://id.nlm.nih.gov/mesh/> {
      ?meshDescriptor rdfs:label ?label .
    }
  }

}
GROUP BY ?meshDescriptor
ORDER BY ?meshDescriptor
```

([View Source](../../../reports/hra-lit-validations/hralit-MeSH_concept-cooccurence-nodeList.rq))
</details>

#### Columns
| meshDescriptor | label | articleCount |
| :--- | :--- | :--- |
| ... | ... | ... |

### <a id="hralit-MeSH_subject_annual_publications"></a>hralit-MeSH_subject_annual_publications



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/UBERON_>
PREFIX cl: <http://purl.obolibrary.org/obo/CL_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
 
SELECT ?descriptor
       ?descriptor_label
       ?year
       (COUNT(?pmid) AS ?publications)

FROM HRAlit:
FROM NAMED <http://id.nlm.nih.gov/mesh/>
WHERE {
  # Article metadata
	?article schema:about ?descriptor ; # Key for filter.
           a schema:ScholarlyArticle ;
           schema:identifier ?pmid ;
           schema:datePublished ?datePublished .

   # Extract publication year from datePublished
   BIND(xsd:integer(
            IF(CONTAINS(?datePublished, "-"),
            STRBEFORE(?datePublished, "-"),
            IF(STRLEN(STR(?datePublished)) >= 4,
                SUBSTR(STR(?datePublished), 1, 4),
                STR(?datePublished)
                )
            )  
        ) AS ?year
    )   

  # Skeleton - MeSH
  GRAPH <http://id.nlm.nih.gov/mesh/> {
    ?descriptor rdfs:label ?descriptor_label .
  }
  FILTER(?descriptor = mesh:D012863)
}

GROUP BY ?descriptor ?descriptor_label ?year
ORDER BY DESC(?year)
```

([View Source](../../../reports/hra-lit-validations/hralit-MeSH_subject_annual_publications.rq))
</details>

#### Columns
| descriptor | descriptor_label | year | publications |
| :--- | :--- | :--- | :--- |
| ... | ... | ... | ... |

### <a id="hralit-OBO_subject_annual_publications"></a>hralit-OBO_subject_annual_publications



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/UBERON_>
PREFIX cl: <http://purl.obolibrary.org/obo/CL_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT 
?subject ?subject_label ?year (COUNT(?article) AS ?article_count)
WHERE {
  # Article selection
  ?article skos:relatedMatch ?subject ;
           schema:datePublished ?datePublished .
    
  # Uberon and CL labels
  ?subject rdfs:label ?subject_label .

  BIND(xsd:integer(
        IF(CONTAINS(?datePublished, "-"),
        STRBEFORE(?datePublished, "-"),
        IF(STRLEN(STR(?datePublished)) >= 4,
            SUBSTR(STR(?datePublished), 1, 4),
            STR(?datePublished)
            )
        )  
    ) AS ?year
  ) 

  # Filter examples
  FILTER(
    ?subject = uberon:0000426 ||                    # extravillous trophoblast
    ?subject = cl:0000066 ||                        # epithelial cell (example)
    ?subject IN (uberon:0000426, cl:0000066)        # Alternative syntax
  )
  # FILTER(?subject_label = "extravillous trophoblast")
  # FILTER(CONTAINS(STR(?subject), "0000426"))
}
GROUP BY ?subject ?subject_label ?year
ORDER BY ?subject_label desc(?year)
```

([View Source](../../../reports/hra-lit-validations/hralit-OBO_subject_annual_publications.rq))
</details>

#### Columns
| subject | subject_label | year | article_count |
| :--- | :--- | :--- | :--- |
| ... | ... | ... | ... |

### <a id="hralit-author_person+article_id-lists+year"></a>hralit-author_person+article_id-lists+year



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/UBERON_>
PREFIX cl: <http://purl.obolibrary.org/obo/CL_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT
(CONCAT(COALESCE(?lastName, " ") ,", ",COALESCE(?firstName, " ")) AS ?authorName)
?pmid
?year

FROM HRAlit: 
WHERE {
   ?article schema:author ?author ;
            schema:datePublished ?datePublished ;
            schema:identifier ?pmid .
   
   # Author name information
   ?author a schema:Person ;
           schema:name ?name ;
           schema:givenName ?firstName ;
           schema:familyName ?lastName .
   # Extract publication year from datePublished
   BIND(xsd:integer(
            IF(CONTAINS(?datePublished, "-"),
            STRBEFORE(?datePublished, "-"),
            IF(STRLEN(STR(?datePublished)) >= 4,
                SUBSTR(STR(?datePublished), 1, 4),
                STR(?datePublished)
                )
            )  
        ) AS ?year
    )   

  #FILTER(?mesh = mesh:D007668)
  FILTER EXISTS {?article schema:about mesh:D007668}  # Kidney
  FILTER EXISTS {?article schema:about mesh:D020869}  # Gene Expression Profiling
  FILTER EXISTS {?article schema:about mesh:D006801}  # Human studies

  # Year filter
  FILTER(?year <= 2024)
  }
ORDER BY ?authorName
```

([View Source](../../../reports/hra-lit-validations/hralit-author_person+article_id-lists+year.rq))
</details>

#### Columns
| authorName | pmid | year |
| :--- | :--- | :--- |
| ... | ... | ... |

### <a id="hralit-expert_identification-organizations"></a>hralit-expert_identification-organizations



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/UBERON_>
PREFIX cl: <http://purl.obolibrary.org/obo/CL_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT
(?name AS ?groupAuthorName)
(COUNT(?article) AS ?articles)

FROM HRAlit: 
WHERE {
   ?article schema:author ?author ;
            schema:datePublished ?datePublished .
   
   # Author name information
   ?author a schema:Organization ;
           schema:name ?name .

   # Extract publication year from datePublished
   BIND(xsd:integer(
            IF(CONTAINS(?datePublished, "-"),
            STRBEFORE(?datePublished, "-"),
            IF(STRLEN(STR(?datePublished)) >= 4,
                SUBSTR(STR(?datePublished), 1, 4),
                STR(?datePublished)
                )
            )  
        ) AS ?year
    )   

  #FILTER(?mesh = mesh:D007668)
  FILTER EXISTS {?article schema:about mesh:D007668}  # Kidney
  FILTER EXISTS {?article schema:about mesh:D020869}  # Gene Expression Profiling
  FILTER EXISTS {?article schema:about mesh:D006801}  # Human studies

  # Year filter
  FILTER(?year <= 2024)

}
GROUP BY ?name
ORDER BY DESC(?articles)
```

([View Source](../../../reports/hra-lit-validations/hralit-expert_identification-organizations.rq))
</details>

#### Columns
| groupAuthorName | articles |
| :--- | :--- |
| ... | ... |

### <a id="hralit-expert_identification-persons"></a>hralit-expert_identification-persons



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/UBERON_>
PREFIX cl: <http://purl.obolibrary.org/obo/CL_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT
(CONCAT(COALESCE(?lastName, " ") ,", ",COALESCE(?firstName, " ")) AS ?authorName)
(COUNT(?article) AS ?articles)

FROM HRAlit: 
WHERE {
   ?article schema:author ?author ;
            schema:datePublished ?datePublished .
   
   # Author name information
   ?author a schema:Person ;
           schema:name ?name ;
           schema:givenName ?firstName ;
           schema:familyName ?lastName .

   # Extract publication year from datePublished
   BIND(xsd:integer(
            IF(CONTAINS(?datePublished, "-"),
            STRBEFORE(?datePublished, "-"),
            IF(STRLEN(STR(?datePublished)) >= 4,
                SUBSTR(STR(?datePublished), 1, 4),
                STR(?datePublished)
                )
            )  
        ) AS ?year
    )   

  #FILTER(?mesh = mesh:D007668)
  FILTER EXISTS {?article schema:about mesh:D007668}  # Kidney
  FILTER EXISTS {?article schema:about mesh:D020869}  # Gene Expression Profiling
  FILTER EXISTS {?article schema:about mesh:D006801}  # Human studies

  # Year filter
  FILTER(?year <= 2024)

}
GROUP BY ?lastName ?firstName
ORDER BY DESC(?articles)
```

([View Source](../../../reports/hra-lit-validations/hralit-expert_identification-persons.rq))
</details>

#### Columns
| authorName | articles |
| :--- | :--- |
| ... | ... |

### <a id="hralit-journal_annual_publications"></a>hralit-journal_annual_publications



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/UBERON_>
PREFIX cl: <http://purl.obolibrary.org/obo/CL_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT #?descriptor
       #?descriptor_label
       ?journal
       ?journal_title 
       ?year
       (COUNT(?pmid) AS ?publications)

FROM HRAlit:
FROM NAMED <http://id.nlm.nih.gov/mesh/>
WHERE {
  # Article metadata
	#?article schema:about ?descriptor ; # Key for filter.
    ?article schema:isPartOf ?journal ; # Key for filter ?journal
            a schema:ScholarlyArticle ;
            schema:identifier ?pmid ;
            schema:datePublished ?datePublished .

   # Extract publication year from datePublished
   BIND(xsd:integer(
            IF(CONTAINS(?datePublished, "-"),
            STRBEFORE(?datePublished, "-"),
            IF(STRLEN(STR(?datePublished)) >= 4,
                SUBSTR(STR(?datePublished), 1, 4),
                STR(?datePublished)
                )
            )  
        ) AS ?year
    )   
  
  # Journal Title (x2 Journal of agricultural and food chemistry and Human Cell)
  ?journal a schema:Periodical ;
           schema:name ?journal_title . # Key for filter ?journal_title
  FILTER(?journal = <https://purl.humanatlas.io/graph/hra-lit#j-374755>  || 
         ?journal_title = "Human cell"
        )

  # Skeleton
  # GRAPH <http://id.nlm.nih.gov/mesh/> {
  #   ?descriptor rdfs:label ?descriptor_label .
  # }
  #FILTER(?descriptor = mesh:D012863)
}

GROUP BY ?journal ?journal_title ?year
ORDER BY ?journal DESC(?year)
```

([View Source](../../../reports/hra-lit-validations/hralit-journal_annual_publications.rq))
</details>

#### Columns
| journal | journal_title | year | publications |
| :--- | :--- | :--- | :--- |
| ... | ... | ... | ... |

### <a id="hralit-meshDescriptor-publicationCountDistinct"></a>hralit-meshDescriptor-publicationCountDistinct



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/uberon#>
PREFIX cl: <http://purl.obolibrary.org/obo/cl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>

SELECT DISTINCT ?meshDescriptor ?label (COUNT(?pmid) AS ?count)
WHERE {

    ?article schema:about ?meshDescriptor ;
             schema:identifier ?pmid .
    ?meshDescriptor rdfs:label ?label .

  FILTER(STRSTARTS(STR(?meshDescriptor), "http://id.nlm.nih.gov/mesh/"))
}
GROUP BY ?meshDescriptor ?label
```

([View Source](../../../reports/hra-lit-validations/hralit-meshDescriptor-publicationCountDistinct.rq))
</details>

#### Columns
| meshDescriptor | label | count |
| :--- | :--- | :--- |
| ... | ... | ... |

### <a id="hralit-publication-mesh-search"></a>hralit-publication-mesh-search



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/uberon#>
PREFIX cl: <http://purl.obolibrary.org/obo/cl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>

SELECT ?pmid
       ?title 
       ?datePublished 
       ?publicationYear
       ?journal_title 
	     (SAMPLE(COALESCE(?abs, " ")) AS ?abstact)
       (GROUP_CONCAT(DISTINCT ?authorName; SEPARATOR="|") AS ?authors)
       (SAMPLE(COALESCE(?volNum, " ")) AS ?vol)
       (SAMPLE(COALESCE(?issNum, " ")) AS ?iss)
       (GROUP_CONCAT(DISTINCT ?subjects; SEPARATOR="|") AS ?subjectHeadings)
       (SAMPLE(COALESCE(?doc_id, " ")) AS ?doi)
FROM HRAlit:
FROM NAMED <http://id.nlm.nih.gov/mesh/>
WHERE {
  # hint:Query hint:analytic "true" .
  # VALUES (?descriptor) {
  #   (mesh:D006325)
  # }
  # Article metadata
	?article schema:about ?descriptor ;
    a schema:ScholarlyArticle ;
    schema:identifier ?pmid ;
    schema:name ?title ;
    schema:datePublished ?datePublished ;
    schema:about ?desc ;
    schema:author ?author ;
    schema:isPartOf ?journal .
  # Extract publication year from datePublished
   BIND(
      IF(CONTAINS(?datePublished, "-"),
         STRBEFORE(?datePublished, "-"),
         IF(STRLEN(STR(?datePublished)) >= 4,
            SUBSTR(STR(?datePublished), 1, 4),
            STR(?datePublished)
         )
      ) AS ?publicationYear
    )   
  # Author names
  ?author schema:name ?authorName .
  # Journal Title
  ?journal a schema:Periodical ;
  schema:name ?journal_title .
  # Mesh Labels
  GRAPH <http://id.nlm.nih.gov/mesh/> {
    ?desc rdfs:label ?subjects .
  }
  OPTIONAL {
    ?article schema:abstract ?abs ;
              schema:sameAs ?doc_id ;
              schema:isPartOf ?volume ;
              schema:isPartOf ?issue .
    ?volume a schema:PublicationVolume ;
            schema:volumeNumber ?volNum .
    ?issue a schema:PublicationIssue ;
            schema:issueNumber ?issNum .
  }

  # Merkle Cell
  FILTER(?descriptor = mesh:D012863)
}

GROUP BY ?pmid ?datePublished ?publicationYear ?title ?journal_title 
ORDER BY DESC(?datePublished)
# LIMIT 200
```

([View Source](../../../reports/hra-lit-validations/hralit-publication-mesh-search.rq))
</details>

#### Columns
| pmid | title | datePublished | publicationYear | journal_title | abstact | authors | vol | iss | subjectHeadings | doi |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |

### <a id="hralit-sssom-MeSH-pubCounts"></a>hralit-sssom-MeSH-pubCounts



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/uberon#>
PREFIX cl: <http://purl.obolibrary.org/obo/cl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>

SELECT ?meshDescriptor (SAMPLE(?label) as ?label) (COUNT(DISTINCT ?article) as ?articleCount)
WHERE {
  # Get SSSOM concepts
  GRAPH <https://purl.humanatlas.io/graph/mesh-uberon-cl-human-mapping> {
    ?oldConcept skos:exactMatch [] .
  }

  # Get current MeSH structure
  GRAPH <http://id.nlm.nih.gov/mesh/> {
    ?meshDescriptor
      rdfs:label ?label ;
      meshv:preferredConcept ?oldConcept .
  }

  GRAPH HRAlit: {
    ?article schema:about ?meshDescriptor .
  }
}
GROUP BY ?meshDescriptor
ORDER BY DESC(?articleCount)

```

([View Source](../../../reports/hra-lit-validations/hralit-sssom-MeSH-pubCounts.rq))
</details>

#### Columns
| meshDescriptor | label | articleCount |
| :--- | :--- | :--- |
| ... | ... | ... |

### <a id="hralit-subject+journal_annual_publications"></a>hralit-subject+journal_annual_publications



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX uberon: <http://purl.obolibrary.org/obo/UBERON_>
PREFIX cl: <http://purl.obolibrary.org/obo/CL_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX HRAlit: <https://purl.humanatlas.io/graph/hra-lit>
PREFIX hint: <http://www.bigdata.com/queryHints#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
 

SELECT ?descriptor
       ?descriptor_label
       ?journal_title 
       ?year
       (COUNT(?pmid) AS ?publications)

FROM HRAlit:
FROM NAMED <http://id.nlm.nih.gov/mesh/>
WHERE {
   # Article metadata
	 ?article schema:about ?descriptor ; # Key for filter.
            schema:isPartOf ?journal ; # Key for filter ?journal
            a schema:ScholarlyArticle ;
            schema:identifier ?pmid ;
            schema:datePublished ?datePublished .

   # Extract publication year from datePublished
   BIND(xsd:integer(
            IF(CONTAINS(?datePublished, "-"),
            STRBEFORE(?datePublished, "-"),
            IF(STRLEN(STR(?datePublished)) >= 4,
                SUBSTR(STR(?datePublished), 1, 4),
                STR(?datePublished)
                )
            )  
        ) AS ?year
    )   
  
  # Journal Title (Publishes papers on skeletons)
  ?journal a schema:Periodical ;
           schema:name ?journal_title . # Key for filter ?journal_title
  FILTER(?journal_title = "American journal of physical anthropology")

  # Skeleton
  GRAPH <http://id.nlm.nih.gov/mesh/> {
     ?descriptor rdfs:label ?descriptor_label .
  }
  FILTER(?descriptor = mesh:D012863)
}

GROUP BY ?journal_title ?descriptor ?descriptor_label ?year
ORDER BY ?journal_title DESC(?year)
```

([View Source](../../../reports/hra-lit-validations/hralit-subject+journal_annual_publications.rq))
</details>

#### Columns
| descriptor | descriptor_label | journal_title | year | publications |
| :--- | :--- | :--- | :--- | :--- |
| ... | ... | ... | ... | ... |

  