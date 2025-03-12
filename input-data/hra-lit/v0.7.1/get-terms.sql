SELECT CONCAT('http://id.nlm.nih.gov/mesh/', ui_d) as descriptor, ui_d as ui, concept_label as label
FROM public.hra_meshc
WHERE exclude = 0
ORDER BY label
