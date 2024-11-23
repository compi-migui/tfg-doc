\newpage
# Results
<!--  Descripció i anàlisis dels resultats obtinguts amb la metodologia proposada -->
Describe results and analyze them. Make sure to include pretty graphs whenever possible. Everybody loves pretty pictures.

## Experimental data used

While we are reproducing the _methodology_ of @vidal_structural_2020, we do not aim to simply put the same experimental data through the same process. We will instead use the data that was generated for @leon_medina_online_2023, which used the same laboratory setup to run additional trials.

@leon_medina_online_2023 deals with stream data classifiers and the data it collected is shaped accordingly: the duration of each of its trials is over 12 times longer than those of @vidal_structural_2020 in order to give its classifiers a chance to train online and start giving accurate results. **TODO: maybe worth going a bit more in depth about online vs. offline classifiers, like a paragraph or two. applications, memory usage, etc.**

Because the methodology we are reproducing uses offline classifiers, which tend to work on the entire data set at once, using this data as-is imposes prohibitive resource requirements: 12 times as much data requires at 12 times as much working memory. While this is technically achievable using professional server hardware, it greatly increases running costs for very marginal or nonexistent benefit. That is why we will not use the data as-is. We will instead truncate the data sets, keeping all the complexity and varability (number of sensors, damage conditions, wind amplitude conditions and trials) while reducing memory requirements six-fold. **TODO: talk about time complexity and memory complexity and how it relates to the algorithms we are using? big O notation etc. Math is fun!**

|                                                         | @vidal_structural_2020 | @leon_medina_online_2023 | Truncated @leon_medina_online_2023 |
|---------------------------------------------------------|------------------------|--------------------------|------------------------------------|
| Structural states ($J$)                                 | 5                      | 5                        | 5                                  |
| Wind amplitudes ($A$)                                   | 4                      | 4                        | 4                                  |
| Total trials, by structural state ($n_i$)               |                        |                          |                                    |
| $n_1$                                                   | 4980                   | 2460                     | 2460                               |
| $n_2$                                                   | 1660                   | 820                      | 820                                |
| $n_3$                                                   | 1660                   | 820                      | 820                                |
| $n_4$                                                   | 1660                   | 820                      | 820                                |
| $n_5$                                                   | 1660                   | 820                      | 820                                |
| $n_{total}$                                             | 11620                  | 5740                     | 5740                               |
| Sensors ($k$)                                           | 24                     | 24                       | 24                                 |
| Timestamps per trial ($L$)                              | 199                    | 2417                     | 403                                |
| Sampling frequency, in Hz                               | 275                    | 275                      | 275                                |
| Readings per trial ($k \cdot L$)                        | 4776                   | 58008                    | 9672                               |
|                                                         |                        |                          |                                    |
| Data set size ($n_{\text{total}} \cdot k \cdot L$)             | 5.55E+07               | 3.33E+08                 | 5.55E+07                           |
| Size ratio                                              | 1.0                    | 6.0                      | 1.0                                |

: Comparison between the shapes of the data used by @vidal_structural_2020, @leon_medina_online_2023 and the truncated version of the latter used in this work. {#tbl:input-data-comparison}

**TODO: better heading for this table? the full citations are cumbersome**

## Performance measures

As we aim to reproduce an existing methodology, in order to make it possible to actually compare our results to @vidal_structural_2020's side by side we will evaluate the models using the same metrics they did. We will also look at a few metrics not evaluated in the original paper, namely the Matthews correlation coefficient (MCC) as described by @chicco_advantages_2020 and the General Performance Score as described by @de_diego_general_2022.

### Binary measures

There can be no doubt that we are tackling a multiclass classification problem. Our data set was gathered from experiments that ran on five structural configurations: one healthy and four of different damaged states. We want our classifiers to be able to discern not simply whether a given trial belongs to a healthy or damaged structure, but to which specific configuration out of the five.

However, when it comes to evaluating the results, it is very useful to start with very simple metrics that we use as stepping stones to reach more generalized or global metrics. These are binary classifier performance measures: designed to evaluate the performance of binary classifiers, but applicable to multiclass classifiers with some creative reshaping of the raw results.

For each of the _classes_ — in our case, structural states — we look only at whether a given sample belongs to it or not (a true/false binary) and whether the classifier asserted it belongs to it or not (another true/false binary). The four possible conditions can be represented as a confusion matrix, a construct reminiscent of but distinct from truth tables. See **TODO: add example truth table**

This gives us our first quantifiable results: out of actually positive samples, ones that were correctly predicted as such are True Positive results (TP) and ones that were incorrectly predicted as negative matches are False Negatives (FN). Conversely, out of actually negative samples, ones that were correctly predicted as such are True Negatives (TN) whereas ones that were incorrectly predicted as positive matches are False Positives (FP).

From there we can compute the rest of the simple binary measures right away. They are:

-   Accuracy: "the degree to which the predictions of a model matches the reality being modeled. In \[the context of classificaton models\], accuracy $= P(\lambda (X) = Y)$ where $XY$ is a joint distribution and the classification model $\lambda$ is a function $X \rightarrow Y$" [@sammut_encyclopedia_2017, p. 8].
$$ \text{acc} = \cfrac{\text{TP} + \text{TN}}{\text{TP} + \text{TN} + \text{FP} + \text{FN}} $$ {#eq:definition-acc}
-   Precision: also known as positive predictive value, it is "the ratio of true positives (TP) and the total number of positives predicted by a model" [@sammut_encyclopedia_2017, p. 990].
$$ \text{ppv} = \cfrac{\text{TP}}{\text{TP} + \text{FP}} $$ {#eq:definition-ppv}
-   Sensitivity: also known as recall or true positive rate. It is "the fraction of positive examples predicted correctly by a model" [@sammut_encyclopedia_2017, p. 1152].
$$ \text{tpr} = \cfrac{\text{TP}}{\text{TP} + \text{FN}} $$ {#eq:definition-tpr}
-   F~1~-measure: also known as F~1~ score. It is "the harmonic mean of precision ... and recall" [@sammut_encyclopedia_2017, p. 497]. The harmonic mean $H$ of $N$ quantities is defined by @abramowitz_handbook_1964 [p. 10] as:
$$\cfrac{1}{H} = \cfrac{\left(\sum\limits_{k=1}^{N} \cfrac{1}{a_n}\right)}{N}$$ {#eq:definition-harmonic-mean}
Thus the F~1~-measure is:
$$ \text{F}_1 = \cfrac{2}{\left(\cfrac{1}{\text{ppv}} + \cfrac{1}{\text{tpr}}\right)} = \cfrac{2\cdot \text{ppv}\cdot \text{tpr}}{\text{ppv}+\text{tpr}} $$ {#eq:definition-f1}
Note that, even though it is not readily apparent in the final simplified form of [@eq:definition-f1], the reprocicals of both accuracy and precision are used in the definition of the F~1~-measure. Because of that, if either of them is zero (e.g. because there are no true positive results) there can be no F~1~-measure. **TODO: actually we can just decide to define it as 0 for that particular case, since it represents an astoundingly bad result. and something similar for others that can end up dividing by 0**
-   Specificity: also known as the true negative rate. It is "the fraction of negative examples predicted correctly by a model" [@sammut_encyclopedia_2017, p. 1167]
$$ \text{tnr} = \cfrac{\text{TN}}{\text{TN} + \text{FP}} $$ {#eq:definition-tnr}

The metrics we have looked at so far are the ones used by @vidal_structural_2020. There is one more we must define before moving on to multiclass measures, as we will use it to compute the General Performance Score mentioned earlier in this section. It is the ambitiously-named unified performance measure (UPM), proposed by @redondo_unified_2020.

In their proposal, @redondo_unified_2020 explain that the unified performance measure "in the imbalanced classification problems, improves the stability of MCC and veracity of Accuracy, F~1~^+ and F~1~^-" and that "the evidence from \[that\] study suggests the use of UPM for both imbalanced and balanced data". As we are dealing with a multiclass problem, the UPM is not directly useful to us, but the General Performance Score that builds on it will be.

The UPM is defined as:
$$ \text{UPM} = \cfrac{1}{1 + \cfrac{(\text{TP} + \text{TN}) \cdot (\text{FP} + \text{FN})}{4 \cdot \text{TP} \cdot \text{TN}}} $$ {#eq:definition-upm}


**TODO: talk about precision/recall tradeoff?**

**TODO: a graphic like the one in oreilly's fig 3-2 illustrating confusion matrices would be neat**

### Multiclass measures

Now that we have laid out a foundation of simple binary measures, it is time to build up to the ones that are actually equipped to describe the performance of multiclass classifiers such as the ones we are dealing with.

Let us first consider the metrics used by @vidal_structural_2020. They are obtained by simply taking, for each of the binary measures described earlier, the average value across all classes (in our case, those are the different structural states) and using that to evaluate the performance of the classifier as a whole.

They are thus:

-   Average accuracy:
$$ \overline{\text{acc}} = \cfrac{\sum\limits_{j=1}^{J} \text{acc}_j}{J} $$ {#eq:definition-avg-acc}
-   Average precision:
$$ \overline{\text{ppv}} = \cfrac{\sum\limits_{j=1}^{J} \text{ppv}_j}{J} $$ {#eq:definition-avg-ppv}
-   Average sensitivity:
$$ \overline{\text{tpr}} = \cfrac{\sum\limits_{j=1}^{J} \text{tpr}_j}{J} $$ {#eq:definition-avg-tpr}
-   Average F~1~-measure: **TODO: is this actually equivalent to the average of the individual F~1~s? actually check and explain explicitly. average of harmonic means vs harmonic mean of averages**
$$ \overline{\text{F}_1} = \cfrac{2\cdot \overline{\text{ppv}}\cdot \overline{\text{tpr}}}{\overline{\text{ppv}}+\overline{\text{tpr}}} $$ {#eq:definition-avg-f1}
-   Average specificity:
$$ \overline{\text{tnr}} = \cfrac{\sum\limits_{j=1}^{J} \text{tnr}_j}{J} $$ {#eq:definition-avg-tnr}

In order to go beyond mere reproduction of what @vidal_structural_2020 did, we will also compute and examine two other multiclass performance measures not present in that work.

One of them is the Matthews correlation coefficient (MCC). Before getting into what it is, we first ought to discuss _why_ one would want to use it — in other words, what problem it aims to solve.

A difficult challenge when evaluating classification models is that it is very easy for some of the metrics discussed so far to tell us more about the shape of the data set being used, rather than about the classifier we are trying to evaluate [@akosa_predictive_2017]. This challenge is doubly difficult because it is very easy to not notice it at all unless one specifically look for it.

For a few very illustrative examples of this problem involving both imbalanced and balanced data sets, see @chicco_advantages_2020 [p. 7-9]. For our purposes, it is enough to take their conclusion as a strong sign that it is a good idea to at least try using the MCC to better examine our models:

>   These results show that, while accuracy and F~1~ score often generate high scores that do not inform the user about ongoing prediction issues, the MCC is a robust, useful, reliable, truthful statistical measure able to correctly reflect the deficiency of any prediction in any dataset.
>   \ — @chicco_advantages_2020 [p. 9]

**TODO: considered going into some of those examples here, but it would be a lot of text to reach that exact same conclusion. probably not worth it unless I end up with too much spare time and too little content**

The Matthews correlation coefficient is defined by @chicco_advantages_2020 as:
$$ \text{MCC}_2 = \cfrac{\text{TP} \cdot \text{TN} - \text{FP} \cdot \text{FN}}{\sqrt{(\text{TP} + \text{FP}) \cdot (\text{TP} + \text{FN}) \cdot (\text{TN} + \text{FP}) \cdot (\text{TN} + \text{FN})}} $$ {#eq:definition-mcc-single}

Some particularly imbalanced data sets and classifiers can lead to the denominator being zero, so we also define some special cases for a complete definition:

$$ \text{MCC}_2 =
\begin{cases}
    1 & \text{if TP $\neq 0$ and FN = FP = TN = 0}\\
    1 & \text{if TN $\neq 0$ and FN = FP = TP = 0}\\
    -1 & \text{if FP $\neq 0$ and FN = TP = TN = 0}\\
    -1 & \text{if FN $\neq 0$ and TP = FP = TN = 0}\\
    0 & \text{if exactly two of (TP, FN, FP, TN) are 0}\\
    \cfrac{\text{TP} \cdot \text{TN} - \text{FP} \cdot \text{FN}}{\sqrt{(\text{TP} + \text{FP}) \cdot (\text{TP} + \text{FN}) \cdot (\text{TN} + \text{FP}) \cdot (\text{TN} + \text{FN})}} & \text{otherwise}
\end{cases} $$ {#eq:definition-mcc-single-special-cases}

**TODO: spacing between does-not-equal sign and 0s is wrong. maybe omit text other than for TP/FN/etc**

Its value can be between -1 and +1. An MCC value of +1 indicates all samples are classified correctly, a value of -1 means they are _all_ classified incorrectly (quite a feat in itself) and a value of 0 denotes exactly half the samples (adjusted for class imbalance) are classified correctly.

An observing reader may protest that the MCC is, in fact, a binary measure. Luckily @gorodkin_comparing_2004 extended it to the multiclass case, defining what he called the R~K~ correlation coefficient but which is referred to by later literature as just the Matthews correlation coefficient applied to multiclass classifiers [@jurman_comparison_2012; @grandini_metrics_2020]. For the sake of simplicity, this work will use just "MCC" to refer to the multiclass version and MCC~2~ for the original binary version.

It is defined as:
$$
\text{MCC} = \cfrac{\sum\limits_{k,l,m=1}^{K} \left( C_{k,k}C_{l,m} - C_{k,l}C_{m,k} \right)}{\sqrt{\sum\limits_{k=1}^{K} \left( \sum\limits_{l=1}^{K} C_{k,l} \right) \left( \sum\limits_{\substack{l\prime =1\\k\prime\neq k}}^{K} C_{k\prime,l\prime} \right)}\sqrt{\sum\limits_{k=1}^{K} \left( \sum\limits_{l=1}^{K} C_{l,k} \right) \left( \sum\limits_{\substack{l\prime =1\\k\prime\neq k}}^{K} C_{l\prime,k\prime} \right)}}
$$ {#eq:definition-mcc}

Where $C_{a,b}$ is the number of samples classified into class _a_ that actually belong to class _b_.

The last metric we will examine is the General Performance Score, proposed by @de_diego_general_2022 and generally defined as the harmonic mean of a set of arbitrary performance measures. We will use one specific instance of it, GPS~UPM~, wherein we parametrize it with the individual Unified Performance Measures derived for each class in our multiclass problem:

$$
\text{GPS}_\text{UPM} = \cfrac{K \cdot \prod\limits_{k=1}^{K} \text{UPM}_k}{\sum\limits_{k\prime=1}^{K} \prod\limits_{\substack{k=1\\k\neq k\prime}}^{K} \text{UPM}_k}
$$ {#eq:definition-gps}

With all our measures finally defined, we can move on to examine the results reached by our classifiers.

## Reproduction

For starters we are going to look at the results generated using the exact methodology reported by @vidal_structural_2020. The same scaling and dimensionality reduction techniques, the same classifiers with the same parameters. That is the point of reproduction: verifying whether a given methodology faced with new data yields similar results.

As mentioned earlier, we are additionally going to compute two new performance measures: the Matthews correlation coefficient and the General Performance Score (the latter parametrized with class-specific Unified Performance Measures). These new metrics may shed some new light on the results or they may merely reinforce what was already apparent from the original results. We shall see.

### Results of kNN

There are two different values we can set to tweak the behavior of the k-NN classifier: one is *k*, the number of neighbors that the algorithm will take into account for each point. The other does not actually belong to the classifier itself, but rather is about the shape of the data we provide it: the number of principal components of the data we feed it.

Much like @vidal_structural_2020 we choose three numbers of principal components: ones that explain 85, 90 and 95% of variance; then we run the classifier using a range of numbers of neighbors between 1 and 500. This sort of sweep lets us judge its performance for several combinations of parameters such that we can hone in on the most sensible approach.

**TODO: Talk about how this brute-force approach is generally best when approaching a new problem using ML, as the "ideal" parameter values can vary wildly depending on characteristics of the data that we cannot really determine beforehand. Make sure to cite relevant works.**

The results for all these permutations are displayed in [@tbl:reproduce-results-table-knn].

Before getting into the performance of the classifier itself, it is worth noting that our data requires more principal components to reach the same explained variance target: for 85% explained variance we need 580 components where @vidal_structural_2020 only needed 443; for 90%, 1034 and 887; for 95%, 1985 and 1770. This is a reasonable difference when we take into account the different sizes of the samples in the respective data sets: we use trials 9672 readings long while they use trials 4776 readings long (see [@tbl:input-data-comparison]).

More complex data has more variability that needs more dimensions to be described with the same precision. The growth is not directly proportional, which means that much of the new information provided by the longer trial can be covered by the same components -- but not all. It remains to be seen if this additional information is useful signal that helps the classifiers or noise that confuses them and throws them off balance.

Looking now at the actual performance metrics in [@tbl:reproduce-results-table-knn] and comparing them to the ones in [@vidal_structural_2020, p.16] we can see a striking similarity. They are quite close, although there is a slight improvement across the board. Where their peak values for accuracy and recall at 90% explained variance were 95.0% and 93.1% ours are 98.08% and 93.33%. This is no doubt the effect of the longer trials: enough extra data was captured to make the classifiers slightly more accurate.

**TODO: do not repeat variance/pc_num values in all rows**
**TODO: put hats over variables in headers if they are averages**

+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|   variance |   pc_num |   k |    acc |    ppv |    tpr |     f1 |    tnr |   gps_upm |    mcc |
+============+==========+=====+========+========+========+========+========+===========+========+
|        85% |      580 |   1 | 93.75% | 84.78% | 84.38% | 84.58% | 95.82% |    88.28% | 79.04% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |   5 | 94.47% | 87.91% | 83.39% | 85.59% | 95.85% |    89.67% | 81.01% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  10 | 93.87% | 87.89% | 80.84% | 84.22% | 95.21% |    88.48% | 78.97% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  25 | 94.06% | 89.31% | 79.95% | 84.37% | 95.28% |    88.43% | 79.86% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  50 | 96.22% | 92.01% | 87.11% | 89.49% | 97.30% |    92.42% | 87.31% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 | 100 | 97.87% | 94.81% | 92.59% | 93.69% | 98.60% |    95.61% | 92.89% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 | 150 | 97.14% | 92.44% | 90.07% | 91.24% | 98.21% |    94.01% | 90.49% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 | 200 | 96.82% | 91.81% | 88.90% | 90.33% | 97.97% |    93.34% | 89.39% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 | 250 | 96.24% | 90.80% | 86.88% | 88.80% | 97.49% |    92.30% | 87.36% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 | 300 | 95.02% | 88.72% | 82.65% | 85.57% | 96.51% |    89.84% | 83.17% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 | 500 | 86.95% | 77.73% | 54.42% | 64.01% | 89.40% |    60.77% | 55.28% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |   1 | 93.80% | 85.03% | 85.35% | 85.19% | 95.99% |    88.47% | 79.52% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |   5 | 94.08% | 86.60% | 83.39% | 84.96% | 95.70% |    89.12% | 79.73% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  10 | 93.60% | 85.28% | 81.25% | 83.22% | 95.33% |    87.74% | 78.01% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  25 | 94.71% | 89.20% | 82.61% | 85.78% | 96.00% |    89.58% | 82.04% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  50 | 96.43% | 92.23% | 87.85% | 89.98% | 97.55% |    92.67% | 88.10% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 | 100 | 98.08% | 95.12% | 93.33% | 94.22% | 98.78% |    95.95% | 93.62% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 | 150 | 97.23% | 92.62% | 90.37% | 91.48% | 98.28% |    94.15% | 90.79% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 | 200 | 96.73% | 91.63% | 88.60% | 90.09% | 97.92% |    93.14% | 89.11% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 | 250 | 96.06% | 90.42% | 86.26% | 88.29% | 97.39% |    91.88% | 86.79% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 | 300 | 94.98% | 88.67% | 82.50% | 85.47% | 96.49% |    89.69% | 83.05% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 | 500 | 86.98% | 77.90% | 54.51% | 64.13% | 89.43% |    60.95% | 55.38% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |   1 | 93.66% | 84.57% | 85.22% | 84.89% | 95.90% |    88.21% | 79.09% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |   5 | 93.80% | 85.54% | 83.03% | 84.27% | 95.59% |    88.49% | 78.83% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  10 | 93.61% | 84.94% | 81.76% | 83.32% | 95.43% |    87.77% | 78.11% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  25 | 94.92% | 89.35% | 83.51% | 86.33% | 96.22% |    89.92% | 82.79% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  50 | 96.61% | 92.38% | 88.49% | 90.39% | 97.76% |    92.91% | 88.77% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 | 100 | 98.17% | 95.27% | 93.66% | 94.46% | 98.85% |    96.10% | 93.93% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 | 150 | 97.31% | 92.81% | 90.65% | 91.72% | 98.34% |    94.31% | 91.08% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 | 200 | 96.79% | 91.72% | 88.79% | 90.23% | 97.97% |    93.21% | 89.32% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 | 250 | 96.22% | 90.72% | 86.82% | 88.72% | 97.53% |    92.11% | 87.38% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 | 300 | 95.14% | 89.01% | 83.05% | 85.92% | 96.62% |    90.04% | 83.61% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 | 500 | 87.11% | 78.28% | 54.97% | 64.57% | 89.55% |    61.65% | 55.82% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+

: Performance indicators for the k-NN classifier using principal components that explain 85, 90 and 95% of variance. {#tbl:reproduce-results-table-knn}

Another notable difference is the number of nearest neighbors (k) at which the classifier's performance peaks: it was 200 for @vidal_structural_2020 but 100 for our reproduction. This is trivially explained by the different number of samples in the respective data sets: we have used a data set with half as many samples, so of course it is optimal to examine half as many neighbors at a time come classification time.

So far this is exactly what one would expect to see when applying the same model to a different data set. We can say the reproduction has been successful.

For the sake of an ideal 1:1 comparison, [@fig:reproduce-indicators-plot-knn-var0.9] contains a plot of performance indicators for the k-NN classifier using principal components that explain 90% of variance, much like the one that can be found in [@vidal_structural_2020, p.15].

![Indicators evaluating the performance of the k-NN method using 90% of variance. Higher values are better.](reproduce-indicators-plot-knn-var0.9.png){#fig:reproduce-indicators-plot-knn-var0.9 width=80%}

Let us turn our attention to the newly computed metrics, the MCC and the GPS~UPM~, and see if they provide any new insights. They are both, as expected, high when the more classical metrics (acc, ppv, tpr, tnr) are high. The interesting thing about them is that they both worsen — and quite fast — if any one of those are low. For example, in the last row (95% explained variance, 500 nearest neighbors) one could naively see an accuracy of 87.11% and decide the classifier is performing rather well. It would take checking other metrics, particularly the true positive rate, to realize something went awry. But both the MCC and the GPS~UPM~ absolutely _tank_ accordingly, making the problem very hard to miss.

Our failure mode here involved a misleadingly high accuracy and an alarmingly low true positive rate. In other situations the roles could be reversed, or some other metric might be the one telling the full story. This leads to having to forcibly check all these different metrics to get an accurate picture of how a classifier is performing.

However, because the MCC and the GPS~UPM~ account for those cases and actually condense results into a single number, they can be trusted to answer the question "How well is my classifier doing?" all by themselves. If that is the goal, then either of them seem to be a perfectly adequate choice.

This does not mean that they make the other, simpler, metrics obsolete — far from it. A researcher who wishes to take a deeper look at what their model is doing and _how_ (not just _if_) it is coming short must still rely on them. In other words: decide what your goals are and pick your tools accordingly.

In terms of choosing between the MCC and the GPS~UPM~ as a singular metric, these results do not show a clear winner. They both seem to rise and fall together, with the MCC figure consistently lower. It is possible that in other scenarios they would illustrate different things but in the matter at hand they seem to be redundant with each other.

**TODO: (maybe) see if literature seems to agree with these conclusions wrt MCC/GPS**

### Results of SVM

+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|   variance |   pc_num |   ρ |    acc |    ppv |    tpr |     f1 |    tnr |   gps_upm |    mcc |
+============+==========+=====+========+========+========+========+========+===========+========+
|        85% |      580 |   5 | 99.92% | 99.85% | 99.73% | 99.79% | 99.93% |    99.86% | 99.72% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  20 | 99.92% | 99.85% | 99.73% | 99.79% | 99.93% |    99.86% | 99.72% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  30 | 99.93% | 99.90% | 99.78% | 99.84% | 99.94% |    99.89% | 99.76% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  40 | 99.94% | 99.93% | 99.81% | 99.87% | 99.95% |    99.92% | 99.81% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  50 | 99.07% | 97.34% | 96.71% | 97.02% | 99.44% |    97.98% | 96.91% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  60 | 97.69% | 94.30% | 91.95% | 93.11% | 98.63% |    94.99% | 92.44% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  70 | 97.08% | 93.36% | 89.81% | 91.55% | 98.22% |    93.72% | 90.48% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  80 | 95.30% | 95.08% | 83.59% | 88.95% | 95.94% |    91.54% | 84.46% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 |  90 | 93.64% | 94.59% | 77.77% | 85.35% | 94.44% |    87.49% | 79.24% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 | 100 | 92.24% | 93.78% | 72.88% | 82.00% | 93.22% |    83.14% | 74.84% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 | 150 | 86.66% | 91.25% | 53.33% | 67.31% | 88.33% |    42.67% | 56.76% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 | 200 | 83.95% |   nan% | 43.88% |   nan% | 85.96% |      nan% | 46.89% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        85% |      580 | 300 | 79.96% |   nan% | 29.82% |   nan% | 82.46% |      nan% | 28.87% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |   5 | 99.87% | 99.84% | 99.58% | 99.71% | 99.89% |    99.81% | 99.57% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  20 | 99.87% | 99.84% | 99.58% | 99.71% | 99.89% |    99.81% | 99.57% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  30 | 99.87% | 99.84% | 99.58% | 99.71% | 99.89% |    99.81% | 99.57% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  40 | 99.88% | 99.86% | 99.59% | 99.73% | 99.90% |    99.82% | 99.60% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  50 | 99.37% | 98.24% | 97.75% | 97.99% | 99.60% |    98.70% | 97.86% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  60 | 97.79% | 94.54% | 92.29% | 93.40% | 98.68% |    95.25% | 92.75% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  70 | 97.02% | 93.29% | 89.59% | 91.41% | 98.17% |    93.64% | 90.28% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  80 | 95.02% | 95.49% | 82.64% | 88.58% | 95.66% |    91.12% | 83.64% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 |  90 | 93.57% | 94.55% | 77.55% | 85.20% | 94.38% |    87.44% | 79.03% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 | 100 | 92.60% | 93.98% | 74.11% | 82.86% | 93.53% |    84.72% | 75.93% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 | 150 | 86.67% | 91.25% | 53.37% | 67.35% | 88.34% |    44.78% | 56.80% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 | 200 | 84.00% |   nan% | 44.05% |   nan% | 86.00% |      nan% | 47.08% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        90% |     1034 | 300 | 79.96% |   nan% | 29.82% |   nan% | 82.46% |      nan% | 28.87% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |   5 | 99.84% | 99.80% | 99.46% | 99.63% | 99.86% |    99.75% | 99.45% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  20 | 99.84% | 99.80% | 99.46% | 99.63% | 99.86% |    99.75% | 99.45% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  30 | 99.84% | 99.80% | 99.46% | 99.63% | 99.86% |    99.75% | 99.45% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  40 | 99.84% | 99.80% | 99.46% | 99.63% | 99.86% |    99.75% | 99.45% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  50 | 99.74% | 99.45% | 99.07% | 99.26% | 99.80% |    99.53% | 99.10% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  60 | 98.09% | 95.14% | 93.32% | 94.22% | 98.84% |    95.89% | 93.71% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  70 | 96.99% | 93.21% | 89.47% | 91.30% | 98.17% |    93.54% | 90.18% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  80 | 95.12% | 95.58% | 82.97% | 88.82% | 95.74% |    91.37% | 83.95% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 |  90 | 93.51% | 94.51% | 77.33% | 85.05% | 94.33% |    87.31% | 78.83% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 | 100 | 92.59% | 93.97% | 74.06% | 82.82% | 93.52% |    84.75% | 75.88% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 | 150 | 86.64% | 91.24% | 53.28% | 67.27% | 88.31% |    44.17% | 56.71% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 | 200 | 83.99% |   nan% | 44.02% |   nan% | 86.00% |      nan% | 47.05% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+
|        95% |     1985 | 300 | 79.95% |   nan% | 29.80% |   nan% | 82.46% |      nan% | 28.84% |
+------------+----------+-----+--------+--------+--------+--------+--------+-----------+--------+

: Performance indicators for the SVM classifier using principal components that explain 85, 90 and 95% of variance. **(TODO: figure out where the NaNs are coming from. probably terrible results for that ρ leading to division by zero when computing those indicators)** {#tbl:reproduce-results-table-svm}


![Indicators evaluating the performance of the SVM method using 85% of variance. Higher values are better. **TODO: NaNs break this figure bad. maybe just exclude ρ=200 and 300 from it**](reproduce-indicators-plot-svm-var0.85.png){#fig:reproduce-indicators-plot-svm-var0.85 width=80%}

## Proposed improvements

### Results of additional classifier(s)
bad

### Results of scaling and dimensionality reduction on the training set only
*shrug*
