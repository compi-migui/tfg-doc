\newpage
# Abstract
## Abstract
Wind power is already a substantial part of global electricity generation capacity and will be even more important as the world answers the United Nations' urgent call to shift toward sustainability. Structural health monitoring in offshore wind turbines can facilitate this shift by reducing the human and economic costs of their operation. Machine-learning algorithms can be applied to this problem but their adoption is fraught with pitfalls that can prevent replication of results, crucial in all scientific inquiry.

In this thesis we attempt to replicate the results of an existing study which applies the _k_-nearest neighbors and support vector machine classifiers to structural health monitoring of offshore wind turbines. We also evaluate two potential improvements to the original methodology: using the Matthews correlation coefficient and the general performance score as performance measures and enforcing training and test data separation during pre-processing to avoid data leakage.

We find that the results of the original study can be replicated, that the Matthews correlation coefficient proves useful in scenarios with bad classifier performance and that data leakage avoidance corrects a small bias towards overoptimistic results in the original's usage of the support vector machine classifier. This highlights the need for avoiding data leakage, especially in future works that attempt direct application in the industry.

\newpage
## Resum
L'energia eòlica ja és una part important de la capacitat instal·lada de generació elèctrica a nivell global, i ho serà encara més a mesura que el món es recondueixi cap a la sostenibilidad com demanen les Nacions Unides. Aquesta reconducció es pot veure facilitada pel monitoratge de la integritat estructural de turbines eòliques marines, que pot reduir el cost humà i econòmic de la seva operació. Els algorismes d'aprenentatge automàtic hi poden ser útils però el seu ús és ple de riscos que poden impedir la repetició de resultats, essencial a la recerca científica.

A aquest treball intentem repetir els resultats d'un estudi (ja existent) que aplica els classificadors de _k_ veïns més propers i de màquina de vectors de suport al monitoratge de la integritat estructural de turbines eòliques marines. També avaluem dues propostes de millora sobre la metodologia original: fer servir com a mètriques el coeficient de correlació de Matthews i la "general performance score" i aplicar una separació estricta entre dades d'entrenament i dades de prova, per tal d'evitar la fuga de dades.

Determinem que els resultats de l'estudi original són repetibles, que el coeficient de correlació de Matthews resulta útil per casos de mal rendiment dels classificadors i que evitar la fuga de dades corregeix un lleuger biaix cap a resultats massa optimistes a l'aplicació original del classificador de màquina de vectors de suport. Cosa que evidencia la necessitat d'evitar fuga de dades, sobretot si s'intenta posar en pràctica aquestes tècniques a la indústria.

\newpage
## Resumen
La energía eólica ya es una parte importante de la capacidad instalada de generación eléctrica a nivel global, y lo será más todavía a medida que el mundo se reconduzca hacia la sostenibilidad como piden las Naciones Unidas. Esta reconducción puede ser facilitada por la monitorización de la integridad estructural de turbinas eólicas marinas, que puede reducir el coste humano y económico de su operación. Para ello, los algoritmos de aprendizaje automático pueden ser útiles pero su uso está repleto de riesgos que pueden impedir la repetición de resultados, esencial en la investigación científica.

En este trabajo intentamos repetir los resultados de un estudio (ya existente) que aplica los clasificadores de _k_ vecinos más cercanos y de máquina de vectores de soporte a la monitorización de la integridad estructural de turbinas eólicas marinas. También evaluamos dos propuestas de mejora sobre la metodología original: usar como métricas el coeficiente de correlación de Matthews y la "general performance score" y aplicar una separación estricta entre datos de entrenamiento y datos de prueba, para así evitar la fuga de datos.

Determinamos que los resultados del estudio original son repetibles, que el coeficiente de correlación de Mathews resulta útil en casos de mal rendimiento de los clasificadores y que evitar la fuga de datos corrige un ligero sesgo hacia resultados demasiado optimistas en la aplicación original del clasificador de máquina de vectores de soporte. Lo cual pone en evidencia la necesidad de evitar fuga de datos, en especial si se intenta poner en práctica estas técnicas en la industria.
