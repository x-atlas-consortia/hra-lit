# Summary of Reports

  ## Table of Contents

* ad-hoc
  * [mesh_a_organs](#mesh_a_organs)
  * [mesh_anatomy_set](#mesh_anatomy_set)
  * [mesh_methods_set](#mesh_methods_set)
  * [mesh_pmid_uni_test](#mesh_pmid_uni_test)
  * [Class subjects in named graphs in the db (named-graph-class-predicates)](#named-graph-class-predicates)
  * [Predicates in named graphs in the db (named-graph-predicates)](#named-graph-predicates)
  * [Named graphs in the db (named-graphs)](#named-graphs)
* ccf-ad-hoc
  * [ccf-asctb-lookup-list](#ccf-asctb-lookup-list)
  * [ccf-asctb-lookup](#ccf-asctb-lookup)
  * [CCF FMA related MESH terms (ccf-mesh-terms-via-fma)](#ccf-mesh-terms-via-fma)
  * [CCF FMA related MESH terms (ccf-mesh-terms-via-fma_v0.2)](#ccf-mesh-terms-via-fma_v0.2)
  * [CCF UBERON related MESH terms (ccf-mesh-terms-via-uberon-list)](#ccf-mesh-terms-via-uberon-list)
  * [CCF UBERON related MESH terms (ccf-mesh-terms-via-uberon)](#ccf-mesh-terms-via-uberon)
* universe-ad-hoc
  * [PMID-MESH distribution (pmids-per-mesh)](#pmids-per-mesh)



### <a id="mesh_a_organs"></a>mesh_a_organs



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>

SELECT DISTINCT ?descriptor ?ui ?childTreeNum ?label
FROM mesh:

WHERE {
#+ A02 - Musculoskeletal System
# Musculature
{ mesh:D009132 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ Skeleton - captures Pelvis and Knee Joint
{ mesh:D012863 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
}  UNION
#+ A03 - Digestive System
#+ Small and Large Intestines May need to split apart.
{ mesh:D007422 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ Liver
{ mesh:D008099 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ Pancreas
{ mesh:D010179
  meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ A04 - Respiratory System
#+ Lung - includes brochus
{ mesh:D008168 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ Trachea 
{ mesh:D014132 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ A05 - Urogential System
#+ A05.360 - Genital
#+ Uterus
{ mesh:D014599 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ Fallopian tubes
{ mesh:D005187 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ Ovary
{ mesh:D010053 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ Prostate
{ mesh:D011467 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ A05.810 - Urinary Tract
#+ Kidney
{ mesh:D007668 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ Urinary Bladder
{ mesh:D001743 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ Uterer
{ mesh:D014513 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ A07 - Cardiovascular System
#+ Heart
{ mesh:D006321 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ Blood Vessels/Vasculature
{ mesh:D001808 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ A08 - Nervous System
#+ Brain
{ mesh:D001921 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ Spinal Cord 
{ mesh:D013116 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ Peripherial Nervous System
{ mesh:D017933 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ A09 - Sensory Organs
#+ Eyes
{ mesh:D005123 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ A10 - Tissues
#+ Mammary Glands
{ mesh:D042361 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ A15 - Hemic & Immune 
#+ A15.145 - Blood
#+ Blood
{ mesh:D001769 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ A15.378 - Hematopoietic System 
#+ Bone Marrow Cells
{ mesh:D001854 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION 
#+ A15.382 - Immune System
#+ BoneMarrow
{ mesh:D001853 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ A15.382.520 - Lymphatic System
#+ Lymphatic Vasculature
{ mesh:D042601 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ Lymphatic Nodes
{ mesh:D008198 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ Spleen
{ mesh:D013154 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ Thymus Gland
{ mesh:D013950 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ Palatine Tonsil
{ mesh:D014066 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ A16 - Embryonic Structures
#+ Placenta
{ mesh:D010920 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} UNION
#+ A17 - Integumentary System
#+ Skin
{ mesh:D012867 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
  ?descriptor rdfs:label ?label .
  ?descriptor meshv:identifier ?ui .
} 
}
ORDER BY ?childTreeNum

```

([View Source](../../../queries/ad-hoc/mesh_a_organs.rq))
</details>

#### Columns
| descriptor | ui | childTreeNum | label |
| :--- | :--- | :--- | :--- |
| ... | ... | ... | ... |
## ad-hoc

### <a id="mesh_anatomy_set"></a>mesh_anatomy_set



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>

SELECT DISTINCT ?pmid ?descriptor ?label
FROM mesh:

WHERE {
#+ A02 - Musculoskeletal System 
{ mesh:D009141 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ A03 - Digestive System
{ mesh:D004064 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ A04 - Respiratory System 
{ mesh:D012137 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ A05 - Urogenital System
{ mesh:D014566 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ A07 - Cardiovascular System
{ mesh:D002319 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ A08 - Nervous System
{ mesh:D009420 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ A15 - Hemic and Immune Systems
{ mesh:D006424 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Skin
{ mesh:D012867 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Eyes
{ mesh:D005123 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Placenta
{ mesh:D010920 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Breasts
{ mesh:D001940 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Adipose
{ mesh:D000273 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Adrenal Gland
{ mesh:D000311 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
}

}

ORDER BY ?descriptor
```

([View Source](../../../queries/ad-hoc/mesh_anatomy_set.rq))
</details>

#### Columns
| pmid | descriptor | label |
| :--- | :--- | :--- |
| ... | ... | ... |

### <a id="mesh_methods_set"></a>mesh_methods_set



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>

SELECT DISTINCT ?pmid ?descriptor ?label
FROM mesh:

WHERE {
#+ MeSH Descriptor: RNA-Seq
{ mesh:D000081246 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ MeSH Descriptor: Single-Cell Analysis
{ mesh:D059010 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ MeSH Descriptor: Single-Cell Gene Expression Analysis
{ mesh:D000092386 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ MeSH Descriptor: Subtractive Hybridization Techniques
{ mesh:D066251 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ MeSH Descriptor: Metabolomics
{ mesh:D055432 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ MeSH Descriptor: Lipidomics
{ mesh:D000081362 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ MeSH Descriptor: Proteomics
{ mesh:D040901 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ MeSH Descriptor: Proteogenomics
{ mesh:D000071696 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} 
}

ORDER BY ?descriptor

D059010	Single-Cell Analysis
D000092386	Single-Cell Gene Expression Analysis
D000081246	
D066251	Subtractive Hybridization Techniques
D055432	Metabolomics
D000081362	Lipidomics
D040901	Proteomics
D000071696	Proteogenomics

```

([View Source](../../../queries/ad-hoc/mesh_methods_set.rq))
</details>

### <a id="mesh_pmid_uni_test"></a>mesh_pmid_uni_test



<details>
  <summary>View Sparql Query</summary>

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX schema: <http://schema.org/>
PREFIX hra: <https://purl.humanatlas.io/graph/hra-lit-universe>

SELECT DISTINCT ?pmid
FROM mesh:
FROM hra:

WHERE {
#+ Brain
{ mesh:D001921 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Spinal Cord 
{ mesh:D013116 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Eyes
{ mesh:D005123 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Uterus
{ mesh:D014599 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Fallopian tubes
{ mesh:D005187 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Placenta
{ mesh:D010920 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Gonads
{ mesh:D006066 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Prostate
{ mesh:D011467 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Breasts
{ mesh:D001940 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Liver
{ mesh:D008099 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Kidney
{ mesh:D007668 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Lung + Bronchus
{ mesh:D008168 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Larynx
{ mesh:D007830 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Trachea 
{ mesh:D014132 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Heart
{ mesh:D006321 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Small and Large Intestines May need to split apart.
{ mesh:D007422 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
}UNION
#+ Pancreas
{ mesh:D010179
  meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ BoneMarrow
{ mesh:D001853 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Bone Marrow Cells
{ mesh:D001854 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Adipose
{ mesh:D000273 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION 
#+ Adrenal Gland
{ mesh:D000311 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Bladder
{ mesh:D001743 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Uterer
{ mesh:D014513 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Palatine Tonsil
{ mesh:D014066 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Blood Vessels/Vasculature 
{ mesh:D001808 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Lymphatic System includes: spleen, thymus, palentine tonsils,
{ mesh:D008208 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Skin
{ mesh:D012867 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
# Pelvic Bones
{ mesh:D010384 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
 } UNION 
#+ Pelvis (region)
{ mesh:D010388 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Knee Joint
{ mesh:D007719 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} UNION
#+ Knee (region)
{ mesh:D007717 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
}  UNION
#+ Patella
{ mesh:D010329 meshv:treeNumber ?treeNum .
  ?childTreeNum meshv:parentTreeNumber* ?treeNum .
  ?descriptor meshv:treeNumber ?childTreeNum .
} 
#+ Pattern looks for the PMIDs with HRA LIT relevant MeSH Terms
#+ Collects title and publication date for article.
{ ?pmid schema:about ?descriptor .
  hint:Query hint:analytic "true" .
}
}

ORDER BY ?pmid
```

([View Source](../../../queries/ad-hoc/mesh_pmid_uni_test.rq))
</details>

### <a id="named-graph-class-predicates"></a>Class subjects in named graphs in the db (named-graph-class-predicates)

Retrieves all class objects in named graphs in the queried SPARQL database

<details>
  <summary>View Sparql Query</summary>

```sparql
#+ summary: Class subjects in named graphs in the db
#+ description: Retrieves all class objects in named graphs in the queried SPARQL database

SELECT DISTINCT ?graph ?class ?subClass ?predicate
WHERE {
  {GRAPH ?graph {
     ?subject ?predicate [] .
     ?subject rdf:type ?class }}
     UNION
  {GRAPH ?graph {
     [] ?predicate ?object .
     ?object rdf:type ?class }}
  hint:Query hint:analytic "true" .
}
GROUP BY ?graph ?class ?subClass ?predicate
ORDER BY ?graph ?class ?subClass ?predicate

```

([View Source](../../../queries/ad-hoc/named-graph-class-predicates.rq))
</details>

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

([View Source](../../../queries/ad-hoc/named-graph-predicates.rq))
</details>

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

([View Source](../../../queries/ad-hoc/named-graphs.rq))
</details>

#### Results ([View CSV File](reports/ad-hoc/named-graphs.csv))

| graph | triples |
| :--- | :--- |
| http://id.nlm.nih.gov/mesh/ | 18334034 |
| https://purl.humanatlas.io/graph/hra-lit | 3996482 |


### <a id="ccf-asctb-lookup-list"></a>ccf-asctb-lookup-list



<details>
  <summary>View Sparql Query</summary>

```sparql

PREFIX ccf: <http://purl.org/ccf/>
PREFIX CCF: <https://purl.humanatlas.io/graph/ccf>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?iri ?label ?ccf_label

WHERE {
  ?iri ccf:ccf_pref_label ?ccf_label .
  ?iri rdfs:label ?label .
  ?iri ccf:ccf_asctb_type ?asctb_type .
  FILTER(?asctb_type = 'AS')
}

```

([View Source](../../../queries/ccf-ad-hoc/ccf-asctb-lookup-list.rq))
</details>

#### Columns
| iri | label | ccf_label |
| :--- | :--- | :--- |
| ... | ... | ... |
## ccf-ad-hoc

### <a id="ccf-asctb-lookup"></a>ccf-asctb-lookup



<details>
  <summary>View Sparql Query</summary>

```sparql

PREFIX ccf: <http://purl.org/ccf/>
PREFIX CCF: <https://purl.humanatlas.io/graph/ccf>
# PREFIX HRA: <https://purl.humanatlas.io/collection/hra>

SELECT ?asctb_type (COUNT(DISTINCT(?iri)) as ?count)
FROM CCF:
WHERE {
  ?iri ccf:ccf_asctb_type ?asctb_type
}
GROUP BY ?asctb_type
ORDER BY ?asctb_type
```

([View Source](../../../queries/ccf-ad-hoc/ccf-asctb-lookup.rq))
</details>

#### Columns
| asctb_type | count |
| :--- | :--- |
| ... | ... |

### <a id="ccf-mesh-terms-via-fma"></a>CCF FMA related MESH terms (ccf-mesh-terms-via-fma)

Get the MESH dbxrefs from CCF-referenced FMA terms that are referenced by an UBERON term

<details>
  <summary>View Sparql Query</summary>

```sparql
#+ summary: CCF FMA related MESH terms
#+ description: Get the MESH dbxrefs from CCF-referenced FMA terms that are referenced by an UBERON term

PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ccf: <http://purl.org/ccf/>
PREFIX FMA: <http://purl.org/sig/ont/fma/fma>
PREFIX CCF: <https://purl.humanatlas.io/graph/ccf>
PREFIX UBERON: <https://purl.humanatlas.io/vocab/uberon>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?fma ?fma_label ?mesh ?uberon ?uberon_label
WHERE {
  GRAPH CCF: {
    SELECT DISTINCT ?fmaId ?fma_label
    WHERE {
      {
        [] ?pred ?fmaId .
      }
      UNION
      {
        ?fmaId ?pred2 [] .
      }
      FILTER(STRSTARTS(STR(?fmaId), STR(FMA:)))
      ?fmaId rdfs:label ?fma_label .
      hint:SubQuery hint:runOnce true .
    }
  }
  {
    SELECT DISTINCT ?uberon ?uberon_label ?mesh ?fma ?fmaId
    WHERE {
      GRAPH UBERON: {
        ?uberon oboInOwl:hasDbXref ?mesh ;
            oboInOwl:hasDbXref ?fma ;
            rdfs:label ?uberon_label .
        FILTER(STRSTARTS(?mesh, 'MESH:') && STRSTARTS(?fma, 'FMA:'))
        BIND(URI(REPLACE(?fma, 'FMA:', STR(FMA:))) as ?fmaId)
      }
      hint:SubQuery hint:runOnce true .
    }
  }
}
ORDER BY ?uberon_label
```

([View Source](../../../queries/ccf-ad-hoc/ccf-mesh-terms-via-fma.rq))
</details>

### <a id="ccf-mesh-terms-via-fma_v0.2"></a>CCF FMA related MESH terms (ccf-mesh-terms-via-fma_v0.2)

Get the MESH dbxrefs from CCF-referenced FMA terms that are referenced by an UBERON term

<details>
  <summary>View Sparql Query</summary>

```sparql
#+ summary: CCF FMA related MESH terms
#+ description: Get the MESH dbxrefs from CCF-referenced FMA terms that are referenced by an UBERON term

PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ccf: <http://purl.org/ccf/>
PREFIX FMA: <http://purl.org/sig/ont/fma/fma>
PREFIX CCF: <https://purl.humanatlas.io/graph/ccf>
PREFIX UBERON: <https://purl.humanatlas.io/vocab/uberon>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?fma ?fma_label ?mesh ?uberon ?uberon_label
WHERE {
  GRAPH CCF: {
    SELECT DISTINCT ?fmaId ?fma_label
    WHERE {
      {
        [] ?pred ?fmaId .
      }
      UNION
      {
        ?fmaId ?pred2 [] .
      }
      ?fmaId ccf:ccf_asctb_type ?asctb_type .
      FILTER(?asctb_type = 'AS')
      FILTER(STRSTARTS(STR(?fmaId), STR(FMA:)))
      ?fmaId rdfs:label ?fma_label .
      hint:SubQuery hint:runOnce true .
    }
  }
  {
    SELECT DISTINCT ?uberon ?uberon_label ?mesh ?fma ?fmaId
    WHERE {
      GRAPH UBERON: {
        ?uberon oboInOwl:hasDbXref ?mesh ;
            oboInOwl:hasDbXref ?fma ;
            rdfs:label ?uberon_label .
        FILTER(STRSTARTS(?mesh, 'MESH:') && STRSTARTS(?fma, 'FMA:'))
        BIND(URI(REPLACE(?fma, 'FMA:', STR(FMA:))) as ?fmaId)
      }
      hint:SubQuery hint:runOnce true .
    }
  }
}
ORDER BY ?uberon_label
```

([View Source](../../../queries/ccf-ad-hoc/ccf-mesh-terms-via-fma_v0.2.rq))
</details>

### <a id="ccf-mesh-terms-via-uberon-list"></a>CCF UBERON related MESH terms (ccf-mesh-terms-via-uberon-list)

Get the MESH dbxrefs from CCF-referenced UBERON terms

<details>
  <summary>View Sparql Query</summary>

```sparql
#+ summary: CCF UBERON related MESH terms
#+ description: Get the MESH dbxrefs from CCF-referenced UBERON terms

PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ccf: <http://purl.org/ccf/>
PREFIX CCF: <https://purl.humanatlas.io/graph/ccf>
PREFIX UBERON: <https://purl.humanatlas.io/vocab/uberon>
PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>
PREFIX mesh: <http://id.nlm.nih.gov/mesh/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?uberon ?uberon_label ?mesh_ui ?mesh_label
                ?parent_mesh_ui ?parent_mesh_label 
                ?super_parent_mesh_ui ?super_parent_mesh_label
                ?treenum
WHERE {
  {
    GRAPH CCF: {
      SELECT DISTINCT ?uberon
      WHERE {
        {
          [] ?pred ?uberon .
        }
        UNION
        {
          ?uberon ?pred2 [] .
        }

        ?uberon ccf:ccf_asctb_type ?asctb_type .
        FILTER(?asctb_type = 'AS')
      }
    }

    GRAPH UBERON: {
      ?uberon rdfs:label ?uberon_label .
    }

    OPTIONAL {
      GRAPH UBERON: {
        ?uberon oboInOwl:hasDbXref ?meshStr .
        FILTER(STRSTARTS(?meshStr, 'MESH:')) 
        BIND (URI(REPLACE(?meshStr, 'MESH:', STR(mesh:))) AS ?mesh)
      } 
      ?mesh rdfs:label ?mesh_label .
      ?mesh meshv:identifier ?mesh_ui .
      ?mesh meshv:treeNumber ?treenum .
    }

    OPTIONAL {
      GRAPH CCF: {
        ?uberon ccf:ccf_part_of ?parent_uberon .
      }
      GRAPH UBERON: {
        ?parent_uberon oboInOwl:hasDbXref ?parent_meshStr .
        FILTER(STRSTARTS(?parent_meshStr, 'MESH:'))
        BIND (URI(REPLACE(?parent_meshStr, 'MESH:', STR(mesh:))) AS ?mesh)
      }
      ?mesh rdfs:label ?parent_mesh_label .
      ?mesh meshv:identifier ?parent_mesh_ui .
      ?mesh meshv:treeNumber ?treenum2 .
    }

    OPTIONAL {
      GRAPH CCF: {
        ?uberon ccf:ccf_part_of+ ?super_parent_uberon .
      }
      GRAPH UBERON: {
        ?super_parent_uberon oboInOwl:hasDbXref ?super_parent_meshStr .
        FILTER(STRSTARTS(?super_parent_meshStr, 'MESH:'))
        BIND (URI(REPLACE(?super_parent_meshStr, 'MESH:', STR(mesh:))) AS ?mesh)
      }
      ?mesh rdfs:label ?super_parent_mesh_label .
      ?mesh meshv:identifier ?super_parent_mesh_ui . 
      ?mesh meshv:treeNumber ?treenum .
    }
  } 
}

ORDER BY ?treenum
```

([View Source](../../../queries/ccf-ad-hoc/ccf-mesh-terms-via-uberon-list.rq))
</details>

#### Columns
| uberon | uberon_label | mesh_ui | mesh_label | parent_mesh_ui | parent_mesh_label | super_parent_mesh_ui | super_parent_mesh_label | treenum |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| ... | ... | ... | ... | ... | ... | ... | ... | ... |

### <a id="ccf-mesh-terms-via-uberon"></a>CCF UBERON related MESH terms (ccf-mesh-terms-via-uberon)

Get the MESH dbxrefs from CCF-referenced UBERON terms

<details>
  <summary>View Sparql Query</summary>

```sparql
#+ summary: CCF UBERON related MESH terms
#+ description: Get the MESH dbxrefs from CCF-referenced UBERON terms

PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX ccf: <http://purl.org/ccf/>
PREFIX CCF: <https://purl.humanatlas.io/graph/ccf>
PREFIX UBERON: <https://purl.humanatlas.io/vocab/uberon>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?uberon ?uberon_label ?mesh
WHERE {
  GRAPH CCF: {
    SELECT DISTINCT ?uberon
    WHERE {
      {
        [] ?pred ?uberon .
      }
      UNION
      {
        ?uberon ?pred2 [] .
      }
    }
  }
  GRAPH UBERON: {
    ?uberon oboInOwl:hasDbXref ?mesh ;
            rdfs:label ?uberon_label .
    FILTER(STRSTARTS(?mesh, 'MESH:'))
  }
}
ORDER BY ?uberon_label

```

([View Source](../../../queries/ccf-ad-hoc/ccf-mesh-terms-via-uberon.rq))
</details>

#### Columns
| uberon | uberon_label | mesh |
| :--- | :--- | :--- |
| ... | ... | ... |

### <a id="pmids-per-mesh"></a>PMID-MESH distribution (pmids-per-mesh)

Number of PMIDs per MESH term

<details>
  <summary>View Sparql Query</summary>

```sparql
#+ summary: PMID-MESH distribution
#+ description: Number of PMIDs per MESH term

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

([View Source](../../../queries/universe-ad-hoc/pmids-per-mesh.rq))
</details>
## universe-ad-hoc

  