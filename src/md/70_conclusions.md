\newpage
# Conclusions
<!--  Segons els resultats obtinguts, conclusions, limitacions i extensions futures -->

As set out in [@sec:goals], our goals were to replicate the results of an approach to processing accelerometer data from offshore wind turbines for the purpose of Structural Health Monitoring as proposed by @vidal_structural_2020 using new data and to improve that approach by avoiding data leakage.

## Replication
With respect to the first goal, the replication was absolutely successful. Using only their methodology as described in the published paper we were able to obtain virtually identical results with only slight differences explained by the different characteristics of the data we used.

In [@sec:goals-replicate] we discussed the Replication Crisis and how it brought to the foreground the fact that many fields of social and natural sciences face systemic issues with replication and reproduction of published results. We also discussed how the use machine learning in any discipline can greatly exacerbate those issues. Unfortunately, in short, not all published science would survive being faced with this level of scrutiny.

But @vidal_structural_2020 did, as we just showed.

In the process we added two new performance metrics to the mix to determine if they had any advantages compared to the ones measured by the original study: the Matthews correlation coefficient (as applied to multiclass classifiers by @gorodkin_comparing_2004) and the general performance score parametrized with the unified performance measure (GPS~UPM~, as proposed by @de_diego_general_2022).

We found that the Matthews correlation coefficient added value by still being able to measure performance even in the worst scenarios where other measures were not computable, allowing the use of a single measure to judge the performance of a classifier. This would be particularly useful during model tuning, where one wants to iteratively find the optimal classifier parameters that provide the best performance.

With respect to the GPS~UPM~ we found no reason to use it over the Matthews correlation coefficient. It is possible that its advantages simply did not show through in our particular use case, so we cannot rule out it being useful in other scenarios.

## Data leakage avoidance
With respect to the second goal, we were indeed able to apply our modified methodology with strict separation of training and test data during pre-processing.

For the _k_-NN classifier the results did not vary significantly with respect to the original methodology. This leads us to conclude that data leakage issues had no material effect on the obtained results — even if they may have technically been present.

For the SVM classifier the changes led to a small (in absolute terms) but very consistent lowering of model performance, with misclassification errors more than doubling in the best case scenario for both the original and the modified methodology. This lines up with the expectation that motivated the proposed improvement: we wanted to avoid data leaks that would lead to overoptimistic results, and by avoiding them we indeed obtained less optimistic ones.

Therefore we can conclude that for the SVM classifier data leakage issues in the original methodology led to a quite small but quite consistent bias towards overoptimistic results, and that enforcing separation of training and test data during pre-processing corrected the bias.

This does not in any way invalidate the results or the conclusions reached by @vidal_structural_2020. But it does highlight the need for implementing and enforcing workflows that avoid data leakage as championed by @kapoor_leakage_2023, particularly in any future works that attempt to move away from laboratory model data and closer to field data and even direct application in the industry.
