\newpage
# Abstract
## Abstract
Wind power is already a substantial part of global electricity generation capacity and will be even more important as the world answers the United Nations' urgent call to shift toward sustainability. Structural health monitoring in offshore wind turbines can facilitate this shift by reducing the human and economic costs of their operation. Machine-learning algorithms can be applied to this problem but their adoption is fraught with pitfalls that can prevent replication of results, crucial in all scientific inquiry.

In this thesis we attempt to replicate the results of an existing study which applies the _k_-nearest neighbors and support vector machine classifiers to structural health monitoring of offshore wind turbines. We also evaluate two potential improvements to the original methodology: using the Matthews correlation coefficient and the general performance score as performance measures and enforcing training and test data separation during pre-processing to avoid data leakage.

We find that the results of the original study can be replicated, that the Matthews correlation coefficient proves useful in scenarios with bad classifier performance and that data leakage avoidance corrects a small yet consistent bias towards overoptimistic results in the original's usage of the support vector machine classifier. This highlights the need for avoiding data leakage, especially in future works that attempt direct application in the industry.

\newpage
## Resum
Degut a la seva ubicació remota, les activitas d'inspecció i manteniment a turbines eòliques marines són molt costoses tant pel que fa al risc a la vida i la salut de les persones treballadores com al cost econòmic. A mesura que la inversió global en fonts d'energia renovable — incloses les turbines eòliques marines — creix, podem preveure que aquests costos també ho faran tret que es prenguin mesures per evitar-ho.

Un millor processament de la informació de teledetecció pot ajudar a minimitzar el nombre d'intervencions necessàries, i per tant també els corresponents costos humans i econòmics: si podem conèixer amb més certesa l'estat d'una estructura no necessitem que personas es posin a sí mateixes en perill revisant-la en persona tan sovint.

A aquest projecte prenem una (ja existent) prova de concepte que aborda la monitorització de la salut estructural (SHM, per les seves sigles en anglès) mitjançant algorismes d'aprenentatge automàtic, intentem replicar els seus resultats fent servir un altre conjunt de dades experimental i avaluem algunes possibles millores.

\newpage
## Resumen
Debido a su ubicación remota, las actividades de inspección y mantenimiento en turbinas eólicas marinas son muy costosas tanto en términos de riesgo a la vida y la salud de las personas trabajadoras como en coste económico. A medida que la inversión global en fuentes de energía renovable — incluidas las turbinas eólicas marinas — crece, podemos prever que esos costes también lo haga salvo que se tomen medidas para evitarlo.

Un mejor procesamiento de información de teledetección puede ayudar a minimizar el número de intervenciones necesarias, y por tanto también los correspondientes costes humanos y económicos: si podemos conocer con más certeza el estado de una estructura no necesitamos que personas se pongan a sí mismas en peligro revisándola en persona tan a menudo.

En este proyecto tomamos una (ya existente) prueba de concepto que aborda la monitorización de la salud estructural (SHM, por sus siglas en inglés) mediante algoritmos de aprendizaje automático, intentamos replicar sus resultados usando otro conjunto de datos experimental y evaluamos algunas posibles mejoras.
