---
subfigGrid: true
lof: true
---
\newpage
# Methodology
<!--  Descripció d’equips i materials utilitzats per a la realització del treball, metodologia emprada i descripció completa dels experiments realitzats -->
As explained in @sec:goals, we intend to do two different things: firstly, replicating the results of @vidal_structural_2020. Secondly, proposing an improvement to their methodology with which to avoid so-called data leakage.

In this section we will examine in detail how we will achieve each of those two goals.

## Replication
In @sec:goals-replicate we went over the often confusing usages of the words "replication" and "reproduction", and settled on the following definitions:

   - Reproduction: Starting from an existing work, taking all its data, code and analysis to verify if they actually support the obtained results.
   - Replication: Starting from an existing work, but using new data, code and analysis, seeing if similar results can be found "in the specific study context investigated" [@national_academies_of_sciences_engineering_and_medicine_reproducibility_2019, p. 44].

We set out to do the latter: we are not going to simply run already-written code on the original data. Instead, we are going to write new code from scratch that attempts to implement the methodology described by @vidal_structural_2020, and we will use it to process data gathered in a different experiment by @leon_medina_online_2023.

### Avoiding "contamination"
We have already mentioned that this work will use all-new code, rather than reusing @vidal_structural_2020's. This is, at least in part, meant to make the replication more thorough by avoiding the possibility that an implementation detail or bug in the original code influenced the results.

However, the code being new does not guarantee we avoid repeating potential implementation errors: if one were to study a piece of software to understand its inner workings before creating a new one to replace it, it would be altogether too easy to accidentally repeat any mistakes in the original. Seeing the solution to a problem necessarily conditions our understanding of it and the way we approach it.

Therefore, in order to achieve a more thorough replication of the results (as opposed to a simple reproduction of the original, with both the good and the bad) the designer of the new process must avoid being "contaminated" by examining the original implementation, instead relying only on the description of the methodology as included in the original study. This way we eliminate an entire category of replication error.

That is our approach here: the author of this work has not seen even a hint of the code used by the authors of the replicated paper, and has instead written a new implementation from scratch guided only by the methodology described in the paper.

### Choice of software: free and open-source
The code used in this work is freely available in the [shmowt repository](https://github.com/compi-migui/shmowt) on GitHub. It is written in the Python programming language, and uses all free and open-source software (FOSS) libraries, which means anyone can take it, run it, modify it and distribute it without having to pay for costly licenses. This makes it possible for anyone with the technical expertise and minimal time investment to reproduce its results and spot any errors in its implementation.

The code itself and the libraries all being open-source also makes it possible to examine their inner workings, something that proprietary closed-source tools do not allow.

The external libraries used directly, not accounting for dependencies of dependencies, are the following:

   - Scikit-learn, for its pre-processing, decomposition and classification model functionalities [@scikit-learn_development_team_scikit-learn_2024; @pedregosa_scikit-learn_2011].
   - Pandas, for manipulating the large data sets involved in a structured way [@pandas_development_team_pandas-devpandas_2024; @mckinney_data_2010].
   - NumPy, for easily operating on arrays of data [@numpy_development_team_numpy_2024; @harris_array_2020].
   - Matplotlib, for generating graphics [@matplotlib_development_team_matplotlib_2024; @hunter_matplotlib_2007].
   - Joblib, for its robust memoization implementation ("transparent disk-caching of functions and lazy re-evaluation") [@joblib_development_team_joblib_2024].

**TODO: explain a bit more what each of these does. joblib is particularly not obvious**


### Original paper's methodology
How did the paper do it?

#### Data source
Explain that the data _we_ comes from a different experiment generated from the same testbed as the paper.

#### Data reshape
Our data was already reshaped into a matrix like the one the paper describes, but it consisted of (comparatively) too-long experiments that made a normal computer choke when running through them. Explain how I had to slice and cut to keep just the data from a smaller time frame.

#### Scaling
Scal...ing.

#### Dimensionality reduction
Everybody's favorite friend: PCA! What is it? Both in mathematical terms and in pragmatic "this is what it does for us here" terms.

#### Classification
Explain what each of these even is.

**TODO: mention OvO and OvA (One vs One/All)**

##### kNN
It kays the Ns.

##### SVM
Super Vicious Manatee!

[@Fig:reproduce-pca-plot] visualizes the same principal components as the original paper did. Note how the results are different due to using a different data set, but only superficially: not all pairs of principal components match exactly, but their quadratic relationship still shows through. Specifically, [@fig:reproduce-pca-plot-1-vs-2] reveals the exact same shape of concentric circles.

<div id="fig:reproduce-pca-plot" class="subfigures">
![First versus second principal component.](reproduce-pca-plot-1-vs-2.png){#fig:reproduce-pca-plot-1-vs-2 width=40%}
![First versus third principal component.](reproduce-pca-plot-1-vs-3.png){#fig:reproduce-pca-plot-1-vs-3 width=40%}

![First versus fourteenth principal component.](reproduce-pca-plot-1-vs-14.png){#fig:reproduce-pca-plot-1-vs-14 width=40%}
![First versus twenty-fifth principal component.](reproduce-pca-plot-1-vs-25.png){#fig:reproduce-pca-plot-1-vs-25 width=40%}

Scatter plots of a few principal component pairs. Blue dots are trials from the "healthy" set, while other colors are trials of different damage configurations.
</div>

**TODO: in the Results section, add similar PCA plots but coloring by predicted class instead of true class**

#### Cross-validation
This isn't your grandma's boring training/test split!


### Other considerations
I may come up with other stuff to say as I write this up.

## Proposed improvements
Do this instead of that.

### Additional classifier(s)
We'll try another one classifier, called PLACEHOLDER, and we'll compare its results to those of the other classifiers. Explain it here!

Also talk about code stuff if relevant. How did we actually implement the new classifier?

### Scaling and dimensionality reduction on the training set only
The paper does scaling and dimensionality reduction with the entire data set, then separates it out into training and test data. Only the training data is used to train the classifiers, and then we evaluate how well it does at classifying the test data.

What if we do the training/test split **before** going through scaling and dimensionality reduction? How do the results change? Is it a significant difference? Which variation is closer to how this methodology might be applied on a real system?

Also talk about code stuff. How did we actually implement the new workflow? Mention [sklearn pipelines](https://scikit-learn.org/stable/modules/generated/sklearn.pipeline.Pipeline.html) and all that good stuff.
