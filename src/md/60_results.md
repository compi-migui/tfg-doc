\newpage
# Results {#sec:results}
<!--  Descripció i anàlisis dels resultats obtinguts amb la metodologia proposada -->
With the methodology laid out, it is time to discuss the results of applying. We will first cover the source and characteristics of the experimental data used (which, due to this being a replication, is distinct from the original study by @vidal_structural_2020) and the measures used to evaluate the performance of the classifiers.

We will then discuss the results obtained by replication, which we will compare with those shown in the original study. Lastly, we will examine the results obtained by applying the improvement proposed in [@Sec:methodology-proposed-improvement] and examine how they change, if they do at all.

## Experimental data used {#sec:results-data}
While we are replicating the _methodology_ of @vidal_structural_2020, we do not aim to simply put the same experimental data through the same process. We will instead use the data that was generated for @leon_medina_online_2023, which used the same laboratory setup to run additional trials.

@leon_medina_online_2023 deals with stream data classifiers and the data it collected is shaped accordingly: the duration of each of its trials is over 12 times longer than those of @vidal_structural_2020 in order to give its classifiers a chance to train online and start giving accurate results.

Because the methodology we are replicating uses offline classifiers, which tend to work on the entire data set at once, using this data as-is imposes prohibitive resource requirements: 12 times as much data requires at 12 times as much working memory. While this is technically achievable using professional server hardware, it greatly increases running costs for very marginal or nonexistent benefit. That is why we will not use the data as-is. We will instead truncate the data sets, keeping all the complexity and variability (number of sensors, damage conditions, wind amplitude conditions and trials) while reducing memory requirements six-fold.

|                                                         | @vidal_structural_2020 | @leon_medina_online_2023 | Truncated @leon_medina_online_2023 |
|---------------------------------------------------------|------------------------|--------------------------|------------------------------------|
| Structural states ($J$)                                 | 5                      | 5                        | 5                                  |
| Wind amplitudes ($A$)                                   | 4                      | 4                        | 4                                  |
| Total trials, by structural state ($n_j$)               |                        |                          |                                    |
| $n_1$                                                   | 4980                   | 2460                     | 2460                               |
| $n_2$                                                   | 1660                   | 820                      | 820                                |
| $n_3$                                                   | 1660                   | 820                      | 820                                |
| $n_4$                                                   | 1660                   | 820                      | 820                                |
| $n_5$                                                   | 1660                   | 820                      | 820                                |
| $n_{\text{total}}$                                             | 11620                  | 5740                     | 5740                               |
| Sensors ($K$)                                           | 24                     | 24                       | 24                                 |
| Timestamps per trial ($L$)                              | 199                    | 2417                     | 403                                |
| Sampling frequency, in Hz                               | 275                    | 275                      | 275                                |
| Readings per trial ($K \cdot L$)                        | 4776                   | 58008                    | 9672                               |
|                                                         |                        |                          |                                    |
| Data set size ($n_{\text{total}} \cdot K \cdot L$)             | 5.55 $\cdot$ 10^7^               | 3.33 $\cdot$ 10^8^                 | 5.55 $\cdot$ 10^7^                           |
| Size ratio                                              | 1.0                    | 6.0                      | 1.0                                |

: Comparison between the shapes of the data used by @vidal_structural_2020, @leon_medina_online_2023 and the truncated version of the latter used in this final degree thesis. {#tbl:input-data-comparison}

## Performance measures
As we aim to replicate an existing methodology, in order to make it possible to actually compare our results to @vidal_structural_2020's side by side we will evaluate the models using the same metrics they did. We will also look at a few metrics not evaluated in the original paper, namely the Matthews correlation coefficient (MCC) as described by @chicco_advantages_2020 and the general performance score as described by @de_diego_general_2022.

### Binary measures
There can be no doubt that we are tackling a multiclass classification problem. Our data set was gathered from experiments that ran on five structural configurations: one healthy and four of different damaged states. We want our classifiers to be able to discern not simply whether a given trial belongs to a healthy or damaged structure, but to which specific configuration out of the five.

However, when it comes to evaluating the results, it is very useful to start with very simple metrics that we use as stepping stones to reach more generalized or global metrics. These are binary classifier performance measures: designed to evaluate the performance of binary classifiers, but applicable to multiclass classifiers with some creative reshaping of the raw results.

For each of the _classes_ — in our case, structural states — we look only at whether a given sample belongs to it or not (a true/false binary) and whether the classifier asserted it belongs to it or not (another true/false binary). The four possible conditions can be represented as a confusion matrix, a construct reminiscent of but distinct from truth tables. For actual confusion matrices representing the output of our classifiers, see [@Sec:appendix-confusion-matrices].

This gives us our first quantifiable results: out of actually positive samples, ones that were correctly predicted as such are true positive results (TP) and ones that were incorrectly predicted as negative matches are false negatives (FN). Conversely, out of actually negative samples, ones that were correctly predicted as such are true negatives (TN) whereas ones that were incorrectly predicted as positive matches are false positives (FP).

From there we can compute the rest of the simple binary measures right away. They are:

-   **Accuracy**: it is the ratio of the number of correctly classified objects and the total number of objects [@sammut_encyclopedia_2017, p. 8]. It is given by
$$ \text{acc} = \cfrac{\text{TP} + \text{TN}}{\text{TP} + \text{TN} + \text{FP} + \text{FN}}\ \text{.} $$ {#eq:definition-acc}
-   **Precision**: also known as positive predictive value, it is "the ratio of true positives (TP) and the total number of positives predicted by a model" [@sammut_encyclopedia_2017, p. 990]. The ratio is expressed as
$$ \text{ppv} = \cfrac{\text{TP}}{\text{TP} + \text{FP}}\ \text{.} $$ {#eq:definition-ppv}
-   **Sensitivity**: also known as recall or true positive rate. It is "the fraction of positive examples predicted correctly by a model" [@sammut_encyclopedia_2017, p. 1152] and it is expressed as
$$ \text{tpr} = \cfrac{\text{TP}}{\text{TP} + \text{FN}}\ \text{.} $$ {#eq:definition-tpr}
-   **F~1~-measure**: also known as F~1~ score. It is "the harmonic mean of precision ... and recall" [@sammut_encyclopedia_2017, p. 497]. The harmonic mean $H$ of $N$ quantities ($a_1,\ldots,a_N$) is
$$\cfrac{1}{H} = \cfrac{\left(\sum\limits_{k=1}^{N} \cfrac{1}{a_n}\right)}{N}$$ {#eq:definition-harmonic-mean}
[@abramowitz_handbook_1964 p. 10], thus the F~1~-measure is given by
$$ \text{F}_1 = \cfrac{2}{\left(\cfrac{1}{\text{ppv}} + \cfrac{1}{\text{tpr}}\right)} = \cfrac{2\cdot \text{ppv}\cdot \text{tpr}}{\text{ppv}+\text{tpr}}\ \text{.} $$ {#eq:definition-f1}

<!-- Note that, even though it is not readily apparent in the final simplified form of [@Eq:definition-f1], the reprocicals of both accuracy and precision are used in the definition of the F~1~-measure. Because of that, if either of them is zero (e.g. because there are no true positive results) there can be no F~1~-measure. -->
-   **Specificity**: also known as the true negative rate. It is "the fraction of negative examples predicted correctly by a model" [@sammut_encyclopedia_2017, p. 1167] and it is given by
$$ \text{tnr} = \cfrac{\text{TN}}{\text{TN} + \text{FP}}\ \text{.} $$ {#eq:definition-tnr}

The metrics we have looked at so far are the ones used by @vidal_structural_2020. There is one more we must define before moving on to multiclass measures, as we will use it to compute the general performance score mentioned earlier in this section. It is the ambitiously-named unified performance measure (UPM), proposed by @redondo_unified_2020.

In their proposal, @redondo_unified_2020 explain that the unified performance measure "in the imbalanced classification problems, improves the stability of MCC and veracity of Accuracy \[and the F~1~-measure\]" and that "the evidence from \[that\] study suggests the use of UPM for both imbalanced and balanced data". The matter of imbalanced data is covered in [@Sec:results-multiclass-measures].

As we are dealing with a multiclass problem, the UPM is not directly useful to us, but the general performance score that builds on it will be.

The UPM is defined as:
$$ \text{UPM} = \cfrac{1}{1 + \cfrac{(\text{TP} + \text{TN}) \cdot (\text{FP} + \text{FN})}{4 \cdot \text{TP} \cdot \text{TN}}}\ \text{.} $$ {#eq:definition-upm}

### Multiclass measures {#sec:results-multiclass-measures}
Now that we have laid out a foundation of simple binary measures, it is time to build up to the ones that are actually equipped to describe the performance of multiclass classifiers such as the ones we are dealing with.

Let us first consider the metrics used by @vidal_structural_2020. They are obtained by simply taking, for each of the binary measures described earlier, the average value across all classes (in our case, those are the different structural states) and using that to evaluate the performance of the classifier as a whole.

The one exception is the multiclass version of the F~1~-measure, which could be approached in two different ways: averaging class-specific F~1~-measures together results in the so-called macro-averaged F~1~-measure; whereas first finding the average precision and recall and then taking their harmonic mean results in the micro-averaged F~1~-measure. For a discussion on their respective merits, see @hinojosa_lee_performance_2024. The micro-averaged F~1~-measure is the one used by @vidal_structural_2020.

The metrics are thus:

-   **Average accuracy**:
$$ \overline{\text{acc}} = \cfrac{\sum\limits_{j=1}^{J} \text{acc}_j}{J}\ \text{.} $$ {#eq:definition-avg-acc}
-   **Average precision**:
$$ \overline{\text{ppv}} = \cfrac{\sum\limits_{j=1}^{J} \text{ppv}_j}{J}\ \text{.} $$ {#eq:definition-avg-ppv}
-   **Average sensitivity**:
$$ \overline{\text{tpr}} = \cfrac{\sum\limits_{j=1}^{J} \text{tpr}_j}{J}\ \text{.} $$ {#eq:definition-avg-tpr}
-   **Micro-averaged F~1~-measure**:
$$ \overline{\text{F}_1} = \cfrac{2\cdot \overline{\text{ppv}}\cdot \overline{\text{tpr}}}{\overline{\text{ppv}}+\overline{\text{tpr}}}\ \text{.} $$ {#eq:definition-avg-f1}
-   **Average specificity**:
$$ \overline{\text{tnr}} = \cfrac{\sum\limits_{j=1}^{J} \text{tnr}_j}{J}\ \text{.} $$ {#eq:definition-avg-tnr}

In order to go beyond mere replication of what @vidal_structural_2020 did, we will also compute and examine two other multiclass performance measures not present in that work.

One of them is the Matthews correlation coefficient (MCC). Before getting into what it is, we first ought to discuss _why_ one would want to use it — in other words, what problem it aims to solve.

As summarized by @chicco_advantages_2020, the MCC was introduced by @matthews_comparison_1975, who was calculating the correlation between predicted and observed structures of proteins. It was @baldi_assessing_2000 who much later went on to apply it as a performance metric for machine learning classifiers.

A difficult challenge when evaluating classification models is that it is very easy for some of the metrics discussed so far to tell us more about the shape of the data set being used, rather than about the classifier we are trying to evaluate [@akosa_predictive_2017]. This challenge is doubly difficult because it is very easy to not notice it at all unless one specifically looks for it.

In essence, when the samples in a data set are not spread evenly between classes, even classifiers that perform very poorly can obtain misleadingly high values for many of the performance measures discussed so far. These are called imbalanced data sets. @chicco_advantages_2020 [p. 7-9] provide detailed accounts of how different measures behave in those cases.

An example they cover is a hypothetical clinical data set with 9 healthy individuals (negatives) and 91 sick ones (positives), and a classifier that labels all of them as being sick, with the sole exception of one of the sick patients being mislabeled as healthy. With 90 true positives, a single false negative, 9 false positives and not even one true negative they obtain an accuracy value of 90% and an F~1~-measure of 95%: both misleadingly high. The MCC value is 48%, which better conveys the poor performance of the classifier.

This example and their overall conclusion as a strong sign that it is a good idea to at least try using the MCC to better examine our models:

>   These results show that, while accuracy and F~1~ score often generate high scores that do not inform the user about ongoing prediction issues, the MCC is a robust, useful, reliable, truthful statistical measure able to correctly reflect the deficiency of any prediction in any dataset.
>   \ — @chicco_advantages_2020 [p. 9]

The Matthews correlation coefficient is defined by @chicco_advantages_2020 as:
$$ \text{MCC}_2 = \cfrac{\text{TP} \cdot \text{TN} - \text{FP} \cdot \text{FN}}{\sqrt{(\text{TP} + \text{FP}) \cdot (\text{TP} + \text{FN}) \cdot (\text{TN} + \text{FP}) \cdot (\text{TN} + \text{FN})}}\ \text{.} $$ {#eq:definition-mcc-single}

Some particularly imbalanced data sets and classifiers can lead to the denominator being zero, so we also define some special cases for a complete definition:

$$ \text{MCC}_2 =
\begin{cases}
    1 & \text{if TP $\neq 0$ and FN $=$ FP $=$ TN $= 0$}\text{,}\\
    1 & \text{if TN $\neq 0$ and FN $=$ FP $=$ TP $= 0$}\text{,}\\
    -1 & \text{if FP $\neq 0$ and FN $=$ TP $=$ TN $= 0$}\text{,}\\
    -1 & \text{if FN $\neq 0$ and TP $=$ FP $=$ TN $= 0$}\text{,}\\
    0 & \text{if exactly two of (TP, FN, FP, TN) are $0$}\text{,}\\
    \cfrac{\text{TP} \cdot \text{TN} - \text{FP} \cdot \text{FN}}{\sqrt{(\text{TP} + \text{FP}) \cdot (\text{TP} + \text{FN}) \cdot (\text{TN} + \text{FP}) \cdot (\text{TN} + \text{FN})}} & \text{otherwise.}
\end{cases} $$ {#eq:definition-mcc-single-special-cases}

Its value can be between -1 and +1. An MCC value of +1 indicates all samples are classified correctly, a value of -1 means they are _all_ classified incorrectly (quite a feat in itself) and a value of 0 denotes exactly half the samples (adjusted for class imbalance) are classified correctly.

An observing reader may protest that the MCC is, in fact, a binary measure. Luckily @gorodkin_comparing_2004 extended it to the multiclass case, defining what he called the R~K~ correlation coefficient but which is referred to by later literature as just the Matthews correlation coefficient applied to multiclass classifiers [@jurman_comparison_2012; @grandini_metrics_2020]. For the sake of simplicity, this final degree thesis will use just MCC to refer to the multiclass version and MCC~2~ for the original binary version.

It is defined as
$$
\text{MCC} = \cfrac{\sum\limits_{a,b,c} \left( C_{a,a}C_{b,c} - C_{a,b}C_{c,a} \right)}{\sqrt{\sum\limits_{a} \left[ \left( \sum\limits_{b} C_{a,b} \right)  \left( \sum\limits_{\substack{b,a\prime \\ a\prime\neq a}} C_{a\prime,b} \right) \right]}\sqrt{\sum\limits_{a} \left[ \left( \sum\limits_{b} C_{b,a} \right) \left( \sum\limits_{\substack{b,a\prime \\ a\prime\neq a}} C_{b,a\prime} \right) \right] }}\ \text{,}
$$ {#eq:definition-mcc}

where $C_{x,y}$ is the number of samples classified into class $x$ that actually belong to class $y$.


The last metric we will examine is the general performance score, proposed by @de_diego_general_2022 and generally defined as the harmonic mean of a set of arbitrary performance measures. We will use one specific instance of it, GPS~UPM~, wherein we parametrize it with the _J_ individual unified performance measures derived for each class _j_ in our multiclass problem:

$$
\text{GPS}_\text{UPM} = \cfrac{J \cdot \prod\limits_{j} \text{UPM}_j}{\sum\limits_{i=1}^{J} \prod\limits_{\substack{j \\ j\neq i}} \text{UPM}_j}\ \text{.}
$$ {#eq:definition-gps}

With all our measures finally defined, we can move on to examine the results reached by our classifiers.

## Replication
For starters, we are going to look at the results generated using the exact methodology reported by @vidal_structural_2020. The same scaling and dimensionality reduction techniques, the same classifiers with the same parameters. That is the point of replication: verifying whether a given methodology faced with new data yields similar results.

As mentioned earlier, we are additionally going to compute two new performance measures: the Matthews correlation coefficient and the general performance score (the latter parametrized with class-specific unified performance measures). These new metrics may shed some new light on the results or they may merely reinforce what was already apparent from the original results. We shall see.

### _k_-nearest neighbors classifier (_k_-NN) {#sec:results-reproduce-knn}
There are two different values we can set to tweak the behavior of the _k_-NN classifier: one is _k_, the number of neighbors that the algorithm will take into account for each point. The other does not actually belong to the classifier itself, but rather is about the shape of the data we provide it: the number of principal components of the data we feed it.

Much like @vidal_structural_2020 we choose three numbers of principal components: ones that explain 85, 90 and 95% of variance; then we run the classifier using a range of numbers of neighbors between 1 and 500. This sort of sweep lets us judge its performance for several combinations of parameters such that we can hone in on the most sensible approach.

The results for all these permutations are displayed in [@Tbl:reproduce-results-table-knn].

Before getting into the performance of the classifier itself, it is worth noting that our data requires more principal components to reach the same explained variance target: for 85% explained variance we need 580 components where @vidal_structural_2020 only needed 443; for 90%, 1034 and 887; for 95%, 1985 and 1770. This is a reasonable difference when we take into account the different sizes of the samples in the respective data sets: we use trials 9672 readings long while they use trials 4776 readings long (see [@Tbl:input-data-comparison]).

More complex data has more variability that needs more dimensions to be described with the same precision. The growth is not directly proportional, which means that much of the new information provided by the longer trial can be covered by the same components -- but not all. It remains to be seen if this additional information is a useful signal that helps the classifiers or noise that confuses them and throws them off balance.

Looking now at the actual performance metrics in [@Tbl:reproduce-results-table-knn] and comparing them to the ones in @vidal_structural_2020 [p.16] we can see a striking similarity. They are quite close, although there is a slight improvement across the board. Where their peak values for accuracy and recall at 90% explained variance were 95.0% and 93.1% ours are 98.08% and 93.33%. This is no doubt the effect of the longer trials: enough extra data was captured to make the classifiers slightly more accurate.


\begin{table}
\caption{Performance indicators
for the k-NN classifier using principal components that explain 85, 90
and 95\% of variance.}
\label{tbl:reproduce-results-table-knn}

\setlength{\tabcolsep}{6pt} % General space between cols (6pt standard)
\renewcommand{\arraystretch}{1.2} % General space between rows (1 standard)

\footnotesize
\begin{tabular}{rrrrrrrrrr}
\hline
 \thead{Explained\\ variance} & \thead{Number\\ of PCs} & \thead{Neighbors\\ ($k$)} & \thead{Accuracy\\ ($\overline{\text{acc}}$)} & \thead{Precision\\ ($\overline{\text{ppv}}$)} & \thead{Sensitivity\\ ($\overline{\text{tpr}}$)} &  \thead{F\textsubscript{1}‐measure} & \thead{Specificity \\($\overline{\text{tnr}}$)} & \thead{GPS} & \thead{MCC} \\
\hline
 \multirow{11}{*}{85\%} & \multirow{11}{*}{580} & 1 & 93.75\% & 84.78\% & 84.38\% & 84.58\% & 95.82\% & 88.28\% & 79.04\% \\
      &     & 5 & 94.47\% & 87.91\% & 83.39\% & 85.59\% & 95.85\% & 89.67\% & 81.01\% \\
      &     & 10 & 93.87\% & 87.89\% & 80.84\% & 84.22\% & 95.21\% & 88.48\% & 78.97\% \\
      &     & 25 & 94.06\% & 89.31\% & 79.95\% & 84.37\% & 95.28\% & 88.43\% & 79.86\% \\
      &     & 50 & 96.22\% & 92.01\% & 87.11\% & 89.49\% & 97.30\% & 92.42\% & 87.31\% \\
      &     & 100 & 97.87\% & 94.81\% & 92.59\% & 93.69\% & 98.60\% & 95.61\% & 92.89\% \\
      &     & 150 & 97.14\% & 92.44\% & 90.07\% & 91.24\% & 98.21\% & 94.01\% & 90.49\% \\
      &     & 200 & 96.82\% & 91.81\% & 88.90\% & 90.33\% & 97.97\% & 93.34\% & 89.39\% \\
      &     & 250 & 96.24\% & 90.80\% & 86.88\% & 88.80\% & 97.49\% & 92.30\% & 87.36\% \\
      &     & 300 & 95.02\% & 88.72\% & 82.65\% & 85.57\% & 96.51\% & 89.84\% & 83.17\% \\
      &     & 500 & 86.95\% & 77.73\% & 54.42\% & 64.01\% & 89.40\% & 60.77\% & 55.28\% \\
\hline
 \multirow{11}{*}{90\%} & \multirow{11}{*}{1034} & 1 & 93.80\% & 85.03\% & 85.35\% & 85.19\% & 95.99\% & 88.47\% & 79.52\% \\
      &     & 5 & 94.08\% & 86.60\% & 83.39\% & 84.96\% & 95.70\% & 89.12\% & 79.73\% \\
      &     & 10 & 93.60\% & 85.28\% & 81.25\% & 83.22\% & 95.33\% & 87.74\% & 78.01\% \\
      &     & 25 & 94.71\% & 89.20\% & 82.61\% & 85.78\% & 96.00\% & 89.58\% & 82.04\% \\
      &     & 50 & 96.43\% & 92.23\% & 87.85\% & 89.98\% & 97.55\% & 92.67\% & 88.10\% \\
      &     & 100 & 98.08\% & 95.12\% & 93.33\% & 94.22\% & 98.78\% & 95.95\% & 93.62\% \\
      &     & 150 & 97.23\% & 92.62\% & 90.37\% & 91.48\% & 98.28\% & 94.15\% & 90.79\% \\
      &     & 200 & 96.73\% & 91.63\% & 88.60\% & 90.09\% & 97.92\% & 93.14\% & 89.11\% \\
      &     & 250 & 96.06\% & 90.42\% & 86.26\% & 88.29\% & 97.39\% & 91.88\% & 86.79\% \\
      &     & 300 & 94.98\% & 88.67\% & 82.50\% & 85.47\% & 96.49\% & 89.69\% & 83.05\% \\
      &     & 500 & 86.98\% & 77.90\% & 54.51\% & 64.13\% & 89.43\% & 60.95\% & 55.38\% \\
\hline
 \multirow{11}{*}{95\%} & \multirow{11}{*}{1985} & 1 & 93.66\% & 84.57\% & 85.22\% & 84.89\% & 95.90\% & 88.21\% & 79.09\% \\
      &     & 5 & 93.80\% & 85.54\% & 83.03\% & 84.27\% & 95.59\% & 88.49\% & 78.83\% \\
      &     & 10 & 93.61\% & 84.94\% & 81.76\% & 83.32\% & 95.43\% & 87.77\% & 78.11\% \\
      &     & 25 & 94.92\% & 89.35\% & 83.51\% & 86.33\% & 96.22\% & 89.92\% & 82.79\% \\
      &     & 50 & 96.61\% & 92.38\% & 88.49\% & 90.39\% & 97.76\% & 92.91\% & 88.77\% \\
      &     & 100 & 98.17\% & 95.27\% & 93.66\% & 94.46\% & 98.85\% & 96.10\% & 93.93\% \\
      &     & 150 & 97.31\% & 92.81\% & 90.65\% & 91.72\% & 98.34\% & 94.31\% & 91.08\% \\
      &     & 200 & 96.79\% & 91.72\% & 88.79\% & 90.23\% & 97.97\% & 93.21\% & 89.32\% \\
      &     & 250 & 96.22\% & 90.72\% & 86.82\% & 88.72\% & 97.53\% & 92.11\% & 87.38\% \\
      &     & 300 & 95.14\% & 89.01\% & 83.05\% & 85.92\% & 96.62\% & 90.04\% & 83.61\% \\
      &     & 500 & 87.11\% & 78.28\% & 54.97\% & 64.57\% & 89.55\% & 61.65\% & 55.82\% \\
\hline
\end{tabular}

\end{table}

Another notable difference is the number of nearest neighbors (k) at which the classifier's performance peaks: it was 200 for @vidal_structural_2020 but 100 for our replication. This is trivially explained by the different number of samples in the respective data sets: we have used a data set with half as many samples, so of course it is optimal to examine half as many neighbors at a time come classification time.

So far this is exactly what one would expect to see when applying the same model to a different data set. We can say the replication has been successful.

For the sake of an ideal 1:1 comparison, [@Fig:reproduce-indicators-plot-knn-var0.9] contains a plot of performance indicators for the k-NN classifier using principal components that explain 90% of variance, much like the one that can be found in @vidal_structural_2020 [p.15].

![Indicators evaluating the performance of the k-NN method using 90% of variance. Higher values are better.](reproduce-indicators-plot-knn-var0.9.png){#fig:reproduce-indicators-plot-knn-var0.9 width=80%}

Let us turn our attention to the newly computed metrics, the MCC and the GPS~UPM~, and see if they provide any new insights. They are both, as expected, high when the more classical metrics (acc, ppv, tpr, tnr) are high. The interesting thing about them is that they both worsen — and quite fast — if any one of those are low. For example, in the last row (95% explained variance, 500 nearest neighbors) one could naively see an accuracy of 87.11% and decide the classifier is performing rather well. It would take checking other metrics, particularly the true positive rate, to realize something went awry. But both the MCC and the GPS~UPM~ absolutely _tank_ accordingly, making the problem very hard to miss.

Our failure mode here involved a misleadingly high accuracy and an alarmingly low true positive rate. In other situations the roles could be reversed, or some other metric might be the one telling the full story. This leads to having to forcibly check all these different metrics to get an accurate picture of how a classifier is performing.

However, because the MCC and the GPS~UPM~ account for those cases and actually condense results into a single number, they can be trusted to answer the question "How well is my classifier doing?" all by themselves. If that is the goal, then either of them seem to be a perfectly adequate choice.

This does not mean that they make the other, simpler, metrics obsolete — far from it. A researcher who wishes to take a deeper look at what their model is doing and _how_ (not just _if_) it is coming short must still rely on them. In other words: decide what your goals are and pick your tools accordingly.

In terms of choosing between the MCC and the GPS~UPM~ as a singular metric, these results do not show a clear winner. They both seem to rise and fall together, with the MCC figure consistently lower. It is possible that in other scenarios they would illustrate different things but in the matter at hand they seem to be redundant with each other.

### Support vector machine (SVM)
Much like with the _k_-NN classifier there are two knobs we can turn to adjust the behavior of the SVM classifier. One is the number of principal components of the data that we put through it, and the other actually belongs to the SVM classifier itself: $\rho$, the kernel scale parameter, as seen in [@Eq:definition-svm-kernel].

Rather than attempt to work out ahead of time what the optimal kernel scale value is for our data set we simply run different variations so that we can examine the results as a whole. Once again we use three numbers of principal components: ones that explain 85, 90 and 95% of variance. This is the approach used by @vidal_structural_2020.

As we compare our results here with theirs we must keep in mind the note about the number of principal components and data set size explained in @Sec:results-reproduce-knn.

The actual performance metrics of the SVM classifier can be found in [@Tbl:reproduce-results-table-svm]. Looking at it side by side with the ones obtained by @vidal_structural_2020 [p.18] we once again see great similarity with only subtle differences. In both cases we find the best performance in the scenario that uses the fewest principal components. Both the original study and our replication reach peak values of upwards of 99.9% for all metrics.

It seems having fewer but longer trials did not translate to an improvement or worsening of the peak performance of the classifier, unlike the _k_-NN classifier where we saw a slight improvement. The same can be said if we look in isolation at the less optimal configurations, the ones that use more principal components to explain 90% and 95% of variance.


\begin{table}
\caption{Performance indicators for the SVM classifier using principal components that explain 85, 90 and 95\% of variance.}
\label{tbl:reproduce-results-table-svm}

\setlength{\tabcolsep}{6pt} % General space between cols (6pt standard)
\renewcommand{\arraystretch}{1.2} % General space between rows (1 standard)

\footnotesize
\begin{tabular}{rrrrrrrrrr}
\hline
 \thead{Explained\\ variance} & \thead{Number\\ of PCs} & \thead{Kernel scale\\ ($\rho$)} & \thead{Accuracy\\ ($\overline{\text{acc}}$)} & \thead{Precision\\ ($\overline{\text{ppv}}$)} & \thead{Sensitivity\\ ($\overline{\text{tpr}}$)} &  \thead{F\textsubscript{1}‐measure} & \thead{Specificity \\($\overline{\text{tnr}}$)} & \thead{GPS} & \thead{MCC} \\
\hline
 \multirow{13}{*}{85\%} & \multirow{13}{*}{580} & 5 & 99.92\% & 99.85\% & 99.73\% & 99.79\% & 99.93\% & 99.86\% & 99.72\% \\
      &     & 20 & 99.92\% & 99.85\% & 99.73\% & 99.79\% & 99.93\% & 99.86\% & 99.72\% \\
      &     & 30 & 99.93\% & 99.90\% & 99.78\% & 99.84\% & 99.94\% & 99.89\% & 99.76\% \\
      &     & 40 & 99.94\% & 99.93\% & 99.81\% & 99.87\% & 99.95\% & 99.92\% & 99.81\% \\
      &     & 50 & 99.07\% & 97.34\% & 96.71\% & 97.02\% & 99.44\% & 97.98\% & 96.91\% \\
      &     & 60 & 97.69\% & 94.30\% & 91.95\% & 93.11\% & 98.63\% & 94.99\% & 92.44\% \\
      &     & 70 & 97.08\% & 93.36\% & 89.81\% & 91.55\% & 98.22\% & 93.72\% & 90.48\% \\
      &     & 80 & 95.30\% & 95.08\% & 83.59\% & 88.95\% & 95.94\% & 91.54\% & 84.46\% \\
      &     & 90 & 93.64\% & 94.59\% & 77.77\% & 85.35\% & 94.44\% & 87.49\% & 79.24\% \\
      &     & 100 & 92.24\% & 93.78\% & 72.88\% & 82.00\% & 93.22\% & 83.14\% & 74.84\% \\
      &     & 150 & 86.66\% & 91.25\% & 53.33\% & 67.31\% & 88.33\% & 42.67\% & 56.76\% \\
      &     & 200 & 83.95\% & --- & 43.88\% & --- & 85.96\% & --- & 46.89\% \\
      &     & 300 & 79.96\% & --- & 29.82\% & --- & 82.46\% & --- & 28.87\% \\
\hline
 \multirow{13}{*}{90\%} & \multirow{13}{*}{1034} & 5 & 99.87\% & 99.84\% & 99.58\% & 99.71\% & 99.89\% & 99.81\% & 99.57\% \\
      &      & 20 & 99.87\% & 99.84\% & 99.58\% & 99.71\% & 99.89\% & 99.81\% & 99.57\% \\
      &      & 30 & 99.87\% & 99.84\% & 99.58\% & 99.71\% & 99.89\% & 99.81\% & 99.57\% \\
      &      & 40 & 99.88\% & 99.86\% & 99.59\% & 99.73\% & 99.90\% & 99.82\% & 99.60\% \\
      &      & 50 & 99.37\% & 98.24\% & 97.75\% & 97.99\% & 99.60\% & 98.70\% & 97.86\% \\
      &      & 60 & 97.79\% & 94.54\% & 92.29\% & 93.40\% & 98.68\% & 95.25\% & 92.75\% \\
      &      & 70 & 97.02\% & 93.29\% & 89.59\% & 91.41\% & 98.17\% & 93.64\% & 90.28\% \\
      &      & 80 & 95.02\% & 95.49\% & 82.64\% & 88.58\% & 95.66\% & 91.12\% & 83.64\% \\
      &      & 90 & 93.57\% & 94.55\% & 77.55\% & 85.20\% & 94.38\% & 87.44\% & 79.03\% \\
      &      & 100 & 92.60\% & 93.98\% & 74.11\% & 82.86\% & 93.53\% & 84.72\% & 75.93\% \\
      &      & 150 & 86.67\% & 91.25\% & 53.37\% & 67.35\% & 88.34\% & 44.78\% & 56.80\% \\
      &      & 200 & 84.00\% & --- & 44.05\% & --- & 86.00\% & --- & 47.08\% \\
      &      & 300 & 79.96\% & --- & 29.82\% & --- & 82.46\% & --- & 28.87\% \\
\hline
 \multirow{13}{*}{95\%} & \multirow{13}{*}{1985} & 5 & 99.84\% & 99.80\% & 99.46\% & 99.63\% & 99.86\% & 99.75\% & 99.45\% \\
      &      & 20 & 99.84\% & 99.80\% & 99.46\% & 99.63\% & 99.86\% & 99.75\% & 99.45\% \\
      &      & 30 & 99.84\% & 99.80\% & 99.46\% & 99.63\% & 99.86\% & 99.75\% & 99.45\% \\
      &      & 40 & 99.84\% & 99.80\% & 99.46\% & 99.63\% & 99.86\% & 99.75\% & 99.45\% \\
      &      & 50 & 99.74\% & 99.45\% & 99.07\% & 99.26\% & 99.80\% & 99.53\% & 99.10\% \\
      &      & 60 & 98.09\% & 95.14\% & 93.32\% & 94.22\% & 98.84\% & 95.89\% & 93.71\% \\
      &      & 70 & 96.99\% & 93.21\% & 89.47\% & 91.30\% & 98.17\% & 93.54\% & 90.18\% \\
      &      & 80 & 95.12\% & 95.58\% & 82.97\% & 88.82\% & 95.74\% & 91.37\% & 83.95\% \\
      &      & 90 & 93.51\% & 94.51\% & 77.33\% & 85.05\% & 94.33\% & 87.31\% & 78.83\% \\
      &      & 100 & 92.59\% & 93.97\% & 74.06\% & 82.82\% & 93.52\% & 84.75\% & 75.88\% \\
      &      & 150 & 86.64\% & 91.24\% & 53.28\% & 67.27\% & 88.31\% & 44.17\% & 56.71\% \\
      &      & 200 & 83.99\% & --- & 44.02\% & --- & 86.00\% & --- & 47.05\% \\
      &      & 300 & 79.95\% & --- & 29.80\% & --- & 82.46\% & --- & 28.84\% \\
\hline
\end{tabular}

\end{table}


We can however see that the peak performance happens with a different value of $\rho$: for @vidal_structural_2020 the best results happened with values of 90 and 100, whereas we find our peak at a value of 40. This mirrors the different best _k_ we found for the _k_-NN classifier, and can similarly be attributed to the different shape of the data set — we have fewer samples but need more principal components, both of which will make the algorithm behave optimally with different parameters.

This is exactly what one would expect to see when applying the same model to a different data set. The replication has also been successful for this classifier.

A perhaps surprising detail in our results is the fact that three indicators were not computable for the cases where a $\rho$ value of 200 and 300 was used: precision, the F~1~-measure and GPS~UPM~. To understand why, we must look at the raw results of those runs, namely the confusion matrices found in [@Fig:reproduce-conf_matrices-svm-var0.85-0; @Fig:reproduce-conf_matrices-svm-var0.9-0; @Fig:reproduce-conf_matrices-svm-var0.95-0].

We can see that performance was so bad in the $\rho = 200$ case that _all_ samples belonging to the damaged configurations 2 and 4 were misclassified as belonging to the healthy class (true label 0 in the matrices). This means there were no true positives for those classes. No samples belonging to other classes were misclassified into them either, so there were no false positives.

Looking back at the definition for precision in [@Eq:definition-ppv] we see the sum of true positives and false positives in the denominator. When both are zero, as happened in these cases, we end up with a division by zero. This undefined value propagates into the average precision computed in [@Eq:definition-avg-ppv] also making it undefined. The same thing happens to the F~1~-measure, which is derived in part from the precision as seen in [@Eq:definition-avg-f1].

The GPS~UPM~ is the harmonic mean of individual classes' UPM ([@Eq:definition-gps]), which in turn ends up with a division by zero when the number of true positives is zero (see [@Eq:definition-upm]).

So the missing values are not due to a mistake when computing them: they are simply not able to handle the case where a model does not assign even one sample to a given class.

This actually reveals a strength of the Matthews correlation coefficient: even when other measures collapse and become undefined it is still able to gauge the performance of the classifier in a useful way. Looking again at [@Tbl:reproduce-results-table-svm], specifically at the rows where $\rho$ is 200 and 300, since both the F~1~-measure and GPS~UPM~ are undefined so they cannot quantify which performs better. However we can see the MCC assigns a worse score to the $\rho = 300$ case (circa 28%) than to the $\rho = 200$ case (circa 47%).

This would be extremely useful in a situation where one is approaching a problem for the first time not knowing what ranges might be appropriate for a parameter. If we allowed the F~1~-measure or GPS~UPM~ to guide us and tried $\rho$ values of 200 and 300 we would know they are bad values, but we would not know whether we should increase or decrease them to find better results. On the other hand, the MCC would let us quantify how bad they are compared to each other: 200 is better than 300, so we ought to try lowering it.

In this scenario other measures like accuracy and sensitivity would also serve that function, but the Matthews correlation coefficient condenses it all into a single number that we can use as a score. This is very advantageous if we were trying to find the optimal $\rho$ algorithmically, a common practice in machine-learning problems.

[@Fig:reproduce-indicators-plot-knn-var0.9] includes a plot of the performance indicators of the SVM method using 85% of variance for easy comparison with the plot shown by @vidal_structural_2020 [p.19].

![Indicators evaluating the performance of the SVM method using 85% of variance. Higher values are better.](reproduce-indicators-plot-svm-var0.85.png){#fig:reproduce-indicators-plot-svm-var0.85 width=80%}

## Proposed improvement: data leakage avoidance
Now that we have gone over the results obtained in replicating the methodology proposed by @vidal_structural_2020, let us look at the ones obtained after applying our proposed improvement as explained in [@Sec:methodology-proposed-improvement].

### _k_-nearest neighbors classifier (_k_-NN)
In order to ensure these results are as comparable as possible to the earlier ones, we will use all the same values for explained variance and number of nearest neighbors (_k_). The results for all the permutations are displayed in [@Tbl:noleak-results-table-knn].


\begin{table}
\caption{Performance indicators for the k-NN classifier using principal components that explain 85, 90 and 95\% of variance, with data leakage avoidance.}
\label{tbl:noleak-results-table-knn}

\setlength{\tabcolsep}{6pt} % General space between cols (6pt standard)
\renewcommand{\arraystretch}{1.2} % General space between rows (1 standard)

\footnotesize
\begin{tabular}{rrrrrrrrrr}
\hline
 \thead{Explained\\ variance} & \thead{Number\\ of PCs} & \thead{Neighbors\\ ($k$)} & \thead{Accuracy\\ ($\overline{\text{acc}}$)} & \thead{Precision\\ ($\overline{\text{ppv}}$)} & \thead{Sensitivity\\ ($\overline{\text{tpr}}$)} &  \thead{F\textsubscript{1}‐measure} & \thead{Specificity \\($\overline{\text{tnr}}$)} & \thead{GPS} & \thead{MCC} \\
\hline
 \multirow{11}{*}{85\%} & \multirow{11}{*}{530} & 1 & 93.78\% & 84.92\% & 84.69\% & 84.80\% & 95.86\% & 88.39\% & 79.20\% \\
      &     & 5 & 94.31\% & 87.32\% & 83.26\% & 85.24\% & 95.77\% & 89.33\% & 80.46\% \\
      &     & 10 & 93.79\% & 87.46\% & 80.88\% & 84.04\% & 95.20\% & 88.33\% & 78.69\% \\
      &     & 25 & 93.96\% & 88.83\% & 79.72\% & 84.03\% & 95.23\% & 88.21\% & 79.49\% \\
      &     & 50 & 96.08\% & 91.74\% & 86.66\% & 89.13\% & 97.20\% & 92.11\% & 86.85\% \\
      &     & 100 & 97.81\% & 94.61\% & 92.41\% & 93.49\% & 98.56\% & 95.50\% & 92.69\% \\
      &     & 150 & 97.09\% & 92.29\% & 89.88\% & 91.07\% & 98.17\% & 93.90\% & 90.30\% \\
      &     & 200 & 96.69\% & 91.54\% & 88.46\% & 89.97\% & 97.87\% & 93.12\% & 88.94\% \\
      &     & 250 & 96.17\% & 90.62\% & 86.64\% & 88.58\% & 97.44\% & 92.17\% & 87.12\% \\
      &     & 300 & 94.95\% & 88.63\% & 82.41\% & 85.40\% & 96.44\% & 89.73\% & 82.92\% \\
      &     & 500 & 86.93\% & 77.54\% & 54.31\% & 63.87\% & 89.39\% & 60.88\% & 55.16\% \\
\hline
 \multirow{11}{*}{90\%} & \multirow{11}{*}{926} & 1 & 93.76\% & 84.93\% & 85.42\% & 85.17\% & 95.97\% & 88.43\% & 79.44\% \\
      &     & 5 & 93.78\% & 85.76\% & 82.80\% & 84.25\% & 95.52\% & 88.49\% & 78.73\% \\
      &     & 10 & 93.51\% & 84.97\% & 81.18\% & 83.03\% & 95.30\% & 87.56\% & 77.71\% \\
      &     & 25 & 94.65\% & 88.99\% & 82.56\% & 85.65\% & 95.96\% & 89.48\% & 81.82\% \\
      &     & 50 & 96.41\% & 92.01\% & 87.80\% & 89.85\% & 97.56\% & 92.58\% & 88.03\% \\
      &     & 100 & 98.09\% & 95.11\% & 93.37\% & 94.23\% & 98.79\% & 95.97\% & 93.65\% \\
      &     & 150 & 97.23\% & 92.62\% & 90.37\% & 91.48\% & 98.28\% & 94.17\% & 90.81\% \\
      &     & 200 & 96.70\% & 91.55\% & 88.48\% & 89.99\% & 97.89\% & 93.09\% & 88.99\% \\
      &     & 250 & 96.10\% & 90.44\% & 86.39\% & 88.37\% & 97.42\% & 91.93\% & 86.91\% \\
      &     & 300 & 94.94\% & 88.60\% & 82.38\% & 85.37\% & 96.47\% & 89.62\% & 82.93\% \\
      &     & 500 & 86.98\% & 77.98\% & 54.50\% & 64.15\% & 89.42\% & 61.12\% & 55.35\% \\
\hline
 \multirow{11}{*}{95\%} & \multirow{11}{*}{1748} & 1 & 93.55\% & 84.38\% & 85.10\% & 84.74\% & 95.85\% & 88.03\% & 78.79\% \\
      &      & 5 & 93.71\% & 85.24\% & 82.87\% & 84.04\% & 95.54\% & 88.27\% & 78.52\% \\
      &      & 10 & 93.51\% & 84.65\% & 81.66\% & 83.13\% & 95.39\% & 87.60\% & 77.78\% \\
      &      & 25 & 94.97\% & 89.42\% & 83.63\% & 86.43\% & 96.26\% & 89.97\% & 82.97\% \\
      &      & 50 & 96.60\% & 92.34\% & 88.42\% & 90.33\% & 97.75\% & 92.86\% & 88.73\% \\
      &      & 100 & 98.21\% & 95.34\% & 93.79\% & 94.56\% & 98.89\% & 96.16\% & 94.07\% \\
      &      & 150 & 97.25\% & 92.69\% & 90.43\% & 91.54\% & 98.29\% & 94.19\% & 90.87\% \\
      &      & 200 & 96.79\% & 91.75\% & 88.82\% & 90.26\% & 97.98\% & 93.22\% & 89.35\% \\
      &      & 250 & 96.13\% & 90.54\% & 86.48\% & 88.46\% & 97.46\% & 91.91\% & 87.05\% \\
      &      & 300 & 95.14\% & 88.99\% & 83.07\% & 85.93\% & 96.64\% & 90.02\% & 83.64\% \\
      &      & 500 & 87.09\% & 78.14\% & 54.89\% & 64.47\% & 89.55\% & 61.84\% & 55.72\% \\
\hline
\end{tabular}
\end{table}

The number of principal components needed to explain a given amount of variance has gone down compared to the replication case. Recall that part of our improvement is to properly hold out the test set during all pre-processing steps, including during dimensionality reduction. Because the principal components are selected using only the training set, which is smaller than the entire set, fewer components are needed to explain its variance.

Looking at the performance indicators, it turns out that the results are functionally identical to the ones reached with the original methodology (seen in [@Tbl:reproduce-results-table-knn]). The numbers vary very slightly up and down, but those represent only a handful of samples being labeled differently. This tiny variation seems to go in either direction, sometimes worsening and sometimes improving the results compared to the base case.

With these figures in hand we can confidently say that, at least for the _k_-NN classifier, data leakage issues had no material effect on the obtained results — even if they may have technically been present.

![Indicators evaluating the performance of the k-NN method using 90% of variance, with data leakage avoidance. Higher values are better.](reproduce-indicators-plot-knn-var0.9.png){#fig:noleak-indicators-plot-knn-var0.9 width=80%}


### Support vector machine (SVM)
Once again we will use all the same values for explained variance and kernel scale parameter ($\rho$) values as we did in the replication case. The results for all the permutations are shown in [@Tbl:noleak-results-table-svm].


\begin{table}
\caption{Performance indicators for the SVM classifier using principal components that explain 85, 90 and 95\% of variance, with data leakage avoidance.}
\label{tbl:noleak-results-table-svm}

\setlength{\tabcolsep}{6pt} % General space between cols (6pt standard)
\renewcommand{\arraystretch}{1.2} % General space between rows (1 standard)

\footnotesize
\begin{tabular}{rrrrrrrrrr}
\hline
 \thead{Explained\\ variance} & \thead{Number\\ of PCs} & \thead{Kernel scale\\ ($\rho$)} & \thead{Accuracy\\ ($\overline{\text{acc}}$)} & \thead{Precision\\ ($\overline{\text{ppv}}$)} & \thead{Sensitivity\\ ($\overline{\text{tpr}}$)} &  \thead{F\textsubscript{1}‐measure} & \thead{Specificity \\($\overline{\text{tnr}}$)} & \thead{GPS} & \thead{MCC} \\
\hline
 \multirow{13}{*}{85\%} & \multirow{13}{*}{530} & 5 & 99.79\% & 99.71\% & 99.29\% & 99.50\% & 99.82\% & 99.67\% & 99.29\% \\
      &     & 20 & 99.79\% & 99.71\% & 99.29\% & 99.50\% & 99.82\% & 99.67\% & 99.29\% \\
      &     & 30 & 99.80\% & 99.73\% & 99.31\% & 99.52\% & 99.83\% & 99.68\% & 99.31\% \\
      &     & 40 & 99.83\% & 99.78\% & 99.41\% & 99.59\% & 99.85\% & 99.73\% & 99.41\% \\
      &     & 50 & 98.91\% & 97.10\% & 96.15\% & 96.62\% & 99.32\% & 97.69\% & 96.37\% \\
      &     & 60 & 97.41\% & 93.88\% & 90.97\% & 92.40\% & 98.44\% & 94.46\% & 91.52\% \\
      &     & 70 & 96.95\% & 93.21\% & 89.36\% & 91.25\% & 98.11\% & 93.55\% & 90.03\% \\
      &     & 80 & 94.97\% & 94.59\% & 82.39\% & 88.05\% & 95.68\% & 90.80\% & 83.38\% \\
      &     & 90 & 93.33\% & 94.40\% & 76.70\% & 84.62\% & 94.17\% & 86.77\% & 78.26\% \\
      &     & 100 & 92.02\% & 93.66\% & 72.09\% & 81.46\% & 93.02\% & 82.48\% & 74.12\% \\
      &     & 150 & 86.28\% & 91.11\% & 52.01\% & 66.21\% & 88.00\% & 30.31\% & 55.51\% \\
      &     & 200 & 83.85\% & --- & 43.51\% & --- & 85.87\% & --- & 46.48\% \\
      &     & 300 & 79.94\% & --- & 29.75\% & --- & 82.44\% & --- & 28.76\% \\
\hline
 \multirow{13}{*}{90\%} & \multirow{13}{*}{926} & 5 & 99.83\% & 99.80\% & 99.39\% & 99.60\% & 99.85\% & 99.73\% & 99.41\% \\
      &     & 20 & 99.83\% & 99.80\% & 99.39\% & 99.60\% & 99.85\% & 99.73\% & 99.41\% \\
      &     & 30 & 99.83\% & 99.80\% & 99.39\% & 99.60\% & 99.85\% & 99.73\% & 99.41\% \\
      &     & 40 & 99.83\% & 99.80\% & 99.39\% & 99.60\% & 99.85\% & 99.73\% & 99.41\% \\
      &     & 50 & 99.18\% & 97.81\% & 97.06\% & 97.44\% & 99.47\% & 98.30\% & 97.24\% \\
      &     & 60 & 97.66\% & 94.33\% & 91.83\% & 93.06\% & 98.58\% & 95.01\% & 92.32\% \\
      &     & 70 & 96.97\% & 93.24\% & 89.40\% & 91.28\% & 98.12\% & 93.57\% & 90.08\% \\
      &     & 80 & 94.72\% & 95.28\% & 81.54\% & 87.85\% & 95.40\% & 90.44\% & 82.68\% \\
      &     & 90 & 93.40\% & 94.45\% & 76.95\% & 84.79\% & 94.23\% & 87.07\% & 78.47\% \\
      &     & 100 & 92.36\% & 93.84\% & 73.28\% & 82.28\% & 93.32\% & 83.96\% & 75.18\% \\
      &     & 150 & 86.47\% & 91.18\% & 52.67\% & 66.76\% & 88.16\% & 37.47\% & 56.14\% \\
      &     & 200 & 83.94\% & --- & 43.80\% & --- & 85.95\% & --- & 46.81\% \\
      &     & 300 & 79.94\% & --- & 29.77\% & --- & 82.45\% & --- & 28.80\% \\
\hline
 \multirow{13}{*}{95\%} & \multirow{13}{*}{1748} & 5 & 99.83\% & 99.81\% & 99.42\% & 99.61\% & 99.85\% & 99.74\% & 99.43\% \\
      &      & 20 & 99.83\% & 99.81\% & 99.42\% & 99.61\% & 99.85\% & 99.74\% & 99.43\% \\
      &      & 30 & 99.83\% & 99.81\% & 99.42\% & 99.61\% & 99.85\% & 99.74\% & 99.43\% \\
      &      & 40 & 99.83\% & 99.81\% & 99.42\% & 99.61\% & 99.85\% & 99.74\% & 99.43\% \\
      &      & 50 & 99.67\% & 99.27\% & 98.84\% & 99.05\% & 99.76\% & 99.40\% & 98.89\% \\
      &      & 60 & 97.91\% & 94.80\% & 92.70\% & 93.74\% & 98.73\% & 95.53\% & 93.12\% \\
      &      & 70 & 96.98\% & 93.21\% & 89.42\% & 91.27\% & 98.15\% & 93.54\% & 90.13\% \\
      &      & 80 & 94.89\% & 95.39\% & 82.10\% & 88.23\% & 95.54\% & 90.80\% & 83.19\% \\
      &      & 90 & 93.42\% & 94.46\% & 77.02\% & 84.84\% & 94.25\% & 87.12\% & 78.54\% \\
      &      & 100 & 92.52\% & 93.93\% & 73.82\% & 82.65\% & 93.45\% & 84.53\% & 75.66\% \\
      &      & 150 & 86.58\% & 91.22\% & 53.05\% & 67.08\% & 88.26\% & 41.62\% & 56.50\% \\
      &      & 200 & 83.97\% & --- & 43.92\% & --- & 85.98\% & --- & 46.95\% \\
      &      & 300 & 79.94\% & --- & 29.77\% & --- & 82.45\% & --- & 28.80\% \\
\hline
\end{tabular}
\end{table}

Much like we saw with the _k_-NN classifier, the results obtained using the modified methodology are very close to the ones obtained earlier. In the SVM classifier, however, there is a noteworthy difference.

Whereas in the _k_-NN classifier the performance measures sometimes did not strictly improve or worsen with the new approach, here we see a very consistent (albeit small) lowering of the scores across the board. This lines up with the expectation that motivated the proposed improvement: we wanted to avoid data leaks that would lead to overoptimistic results, and by avoiding them we indeed obtained less optimistic ones.

Regarding the size of this effect, consider the peak performance in each approach. With the original methodology the highest accuracy was 99.94%; with the new one it is 99.83%. While it might be tempting to call this completely insignificant due to being such a small difference in absolute terms (just 0.11%), consider instead that it represents _more than doubling_ the rate of errors: in the base case the SVM classifier at its best misclassified 3 samples but after avoiding data leaks it misclassified 7 of them.

Therefore we can conclude that for the SVM classifier data leakage issues in the original methodology led to a quite small but quite consistent bias towards overoptimistic results, and that enforcing separation of training and test data during pre-processing corrected the bias.

![Indicators evaluating the performance of the SVM method using 85% of variance, with data leakage avoidance. Higher values are better.](reproduce-indicators-plot-svm-var0.85.png){#fig:noleak-indicators-plot-svm-var0.85 width=80%}
