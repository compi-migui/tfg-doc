\clearpage
\appendix
\appendixtocon
\appendixtitleon
\appendixtitletocon
\appendixheaderon
\appendixpage

# Confusion matrices for all configurations {#sec:appendix-confusion-matrices}
This appendix includes confusion matrices with raw results for classifier configurations used throughout this work. Note that, because we used 5-fold cross-validation, there are actually five different confusion matrices for each configuration which were then used to compute separate performance metrics to be averaged together.

Including all five matrices for all configurations would bloat the size of this document for very questionable value, so only the first one out of five is presented.

## Confusion matrices for the original methodology (replication)
![Confusion matrices for the k-NN classifier using principal components that explain 85% of variance.](reproduce-conf_matrices-knn-var0.85-0.png){#fig:reproduce-conf_matrices-knn-var0.85-0 width=85%}

![Confusion matrices for the k-NN classifier using principal components that explain 90% of variance.](reproduce-conf_matrices-knn-var0.9-0.png){#fig:reproduce-conf_matrices-knn-var0.9-0 width=85%}

![Confusion matrices for the k-NN classifier using principal components that explain 95% of variance.](reproduce-conf_matrices-knn-var0.95-0.png){#fig:reproduce-conf_matrices-knn-var0.95-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 85% of variance.](reproduce-conf_matrices-svm-var0.85-0.png){#fig:reproduce-conf_matrices-svm-var0.85-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 90% of variance.](reproduce-conf_matrices-svm-var0.9-0.png){#fig:reproduce-conf_matrices-svm-var0.9-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 95% of variance.](reproduce-conf_matrices-svm-var0.95-0.png){#fig:reproduce-conf_matrices-svm-var0.95-0 width=85%}

## Confusion matrices for the new methodology (data leakage avoidance)
![Confusion matrices for the k-NN classifier using principal components that explain 85% of variance, with data leakage avoidance.](noleak-conf_matrices-knn-var0.85-0.png){#fig:noleak-conf_matrices-knn-var0.85-0 width=85%}

![Confusion matrices for the k-NN classifier using principal components that explain 90% of variance, with data leakage avoidance.](noleak-conf_matrices-knn-var0.9-0.png){#fig:noleak-conf_matrices-knn-var0.9-0 width=85%}

![Confusion matrices for the k-NN classifier using principal components that explain 95% of variance, with data leakage avoidance.](noleak-conf_matrices-knn-var0.95-0.png){#fig:noleak-conf_matrices-knn-var0.95-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 85% of variance, with data leakage avoidance.](noleak-conf_matrices-svm-var0.85-0.png){#fig:noleak-conf_matrices-svm-var0.85-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 90% of variance, with data leakage avoidance.](noleak-conf_matrices-svm-var0.9-0.png){#fig:noleak-conf_matrices-svm-var0.9-0 width=85%}

![Confusion matrices for the SVM classifier using principal components that explain 95% of variance, with data leakage avoidance.](noleak-conf_matrices-svm-var0.95-0.png){#fig:noleak-conf_matrices-svm-var0.95-0 width=85%}

# Source code
Link to GitHub repo + maybe actual raw code.

[https://github.com/compi-migui/shmowt](https://github.com/compi-migui/shmowt)
