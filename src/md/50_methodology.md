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

**TODO: maybe mention the relevant code bits used in each part of the methodology. this funcion from this library for scaling, etc.**

### Original paper's methodology
Let us describe the original methodology we are trying to replicate.

#### Data source
We do not use the experimental data gathered by @vidal_structural_2020, but rather that gathered by @leon_medina_online_2023's. The actual laboratory model is the same, and they describe it thusly:

>   The data used in this study was obtained from a laboratory-scaled wind turbine. The wind turbine is 2.7 m high and consists of three parts: the jacket, the tower, and the nacelle. ... To simulate the effects of marine waves and wind that offshore structures are subjected to, a white noise signal was applied to a shaker. This signal was then amplified in a function generator by factors of 0.5, 1, 2, and 3. Subsequently, the structure was excited, and its vibration response was measured using eight triaxial accelerometers...

Although the same turbine and sensor configuration is used in both studies, the latter uses longer trials: 9.789 seconds instead of the original's 0.7236 seconds, for over 13 times more readings per trial. It also has fewer total trials: 5740 to the original's 11620, or about half as many.

The larger overall size of the data set has implications for memory requirements and execution time for our entire process. Its different shape has implications for the behavior of the classifiers we will use. The precise impact of both of these is examined more closely in @sec:results.

#### Data reshape
The first challenge encountered when trying to analyze the data is the fact that it is three-dimensional: there is a distinct data point for each triplet of specific trial (out of 5740), specific sensor-axis (out of 24, for the 8 triaxial accelerometers) and specific time instant.

@vidal_structural_2020 propose reshaping the entire data set into a unified two-dimensional matrix where each row contains all the data for a specific trial and each column contains the reading from a specific sensor-axis and timestamp. This shape would be frankly incomprehensible to a human reader, but it suits our pre-processing and classification methods just fine. They attribute this unfolding procedure to @westerhuis_comparing_1999.

**TODO: show matrix like the paper's equation 1, but maybe with quantities like J,K,L turned into our actual numbers for easier reading. could be a cool graph**

An important note is that the data provided to the author of this work by @leon_medina_online_2023 was already shaped into this form. This made the truncation process described in @sec:results-data somewhat more convoluted as it required careful slicing of the rows, but otherwise has no effect on our analysis.

#### Scaling
Next up in the processing pipeline is scaling the data, which @vidal_structural_2020 explain serves "two main reasons: first, to process data that come from different sensors and second, to simplify the computations of the data transformation using PCA".

**TODO: mention problems this avoids, like this quote from https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html: "For instance many elements used in the objective function of a learning algorithm (such as the RBF kernel of Support Vector Machines or the L1 and L2 regularizers of linear models) assume that all features are centered around 0 and have variance in the same order. If a feature has a variance that is orders of magnitude larger than others, it might dominate the objective function and make the estimator unable to learn from other features correctly as expected."**

The scaling is done column by column, and involves adjusting each data point such that the column as a whole has a mean value of zero and a variance of one. The scaled value $\breve{x}_{i,j}^{k,l}$ of a reading $x_{i,j}^{k,l}$ is thus:

$$
\breve{x}_{i,j}^{k,l} = \cfrac{x_{i,j}^{k,l} - \mu_{k,l}}{\sigma_{k,l}}
$$ {#eq:column-scaling}

Where $\mu_{k,l}$ is the mean value of all readings in column "$k,l$" that $x$ belongs to:

$$
\mu_{k,l} = \cfrac{\sum\limits_{i,j} x_{i,j}^{k,l}}{I\cdot J}
$$ {#eq:column-scaling-mean}

And $\sigma_{k,l}$ is the standard deviation of all readings in that same column:

$$
\sigma_{k,l} = \sqrt{\cfrac{1}{I\cdot J}\sum\limits_{i,j} (x_{i,j}^{k,l} - \mu_{k,l})^2}
$$ {#eq:column-scaling-stdev}

Remember that, because of the way the data was structured, scaling along columns means each reading is being standardized among all the readings from that same sensor-axis and time instant across all trials in the data set.

#### Dimensionality reduction
At this point, the values in the data have been scaled column-wise but there are still several thousand columns with readings for each trial. This is far more than most machine-learning algorithms are able to handle without collapsing — either by providing nonsense classifications or by requiring absurdly large amounts of memory and processing capacity.

Consider that the information conveyed by the great majority of those readings is quite redundant and serves only to waste and distract. It is imperative to condense it down to the most salient characteristics: those that are most useful to distinguish one trial from another, as that is what a classification model will ultimately need to evaluate.

If one wanted to describe a list of cars in a way that's optimized to telling them apart, it would be foolish to start each car's description by explaining in detail that it is a physical object, it exists in three-dimensional space, it is artificially made, it is used as a means of transportation, it has wheels... Those are characteristics that (most) all cars share, so they are redundant and superfluous. A better way would be to list make, model, color and license plate numbers of each car: the latter is unique to each one, while the other three allow for broad categorization.

The data set in front of us is a lot more gnarly than the car analogy, but the same principle applies: taking a huge list of data points of dubious usefulness (9672 readings per trial) and turning it into a smaller list of data points that still allow to differentiate a trial from another as much as possible. This is dimensionality reduction.

@vidal_structural_2020 achieve this by way of multiway Principal Component Analysis. Principal Component Analysis (PCA) is a technique that makes it possible "to extract the important information from the table, to represent it as a set of new orthogonal variables called principal components, and to display the pattern of similarity of the observations and of the variables as points in maps" [@abdi_principal_2010]. The "multiway" qualifier is earned by virtue of having reshaped the data in the fashion that we did, combining all readings in a trial into a single row; PCA is applied as usual after that.

Note that PCA by itself does not _reduce_ the dimensions captured in the data (and thus its size): it merely transforms our original matrix into a matrix of the same size, which represents the original data projected onto the newly-found principal components. Visualizing a 9672-dimension rotation is a feat beyond the ability of most people, so this is a case where one can only trust the math.

What actually makes PCA useful here is the fact that those principal components are sorted: the first one will have the largest possible variance, the second one will have the second largest and so on. This translates into the first principal component "explaining" or "extracting" (as phrased by @abdi_principal_2010) the largest possible variance from the original data, the second one "explaining" the second largest possible variance and so forth.

We can therefore truncate the principal components, taking only an arbitrary number of them rather than all 9672, project the data onto that smaller set of components and end up with a significanly smaller data set that still describes a disproportionately large portion of the inter-trial variance of the original data. Explain as much with fewer dimensions.

**TODO: could mention and explain SVD since it's what we actually use to get the PCs**

#### Classification
With the data scaled and reduced to a more manageable size it is time for the machine-learning classifiers to shine. In general terms, the way they work is we first fit them to our problem space using a _training_ data set where each sample is labeled with its known correct class — the gold standard that lets each algorithm be adapted to our goals. Then, with the now trained model, we provide it an unlabeled _test_ data set and have it predict what class each of the samples belongs to. This training/test split is called the holdout method.

Since our goal is to replicate the results of the original paper, we will use the same classifiers it does: the _k_-nearest neighbors classifier and the Support Vector Machine.


##### _k_-nearest neighbors classifier (_k_-NN)
A concept first proposed by @fix_discriminatory_1951, the _k_-NN classifier is brilliantly simple, especially compared to the complexity one might expect when being introduced to the topic of "classification using machine-learning algorithms". Let us go over how it works, starting with some definitions.

Let $x$ be a sample from the test set, represented by a point in $N$-dimensional space where $N$ is the number of principal components preserved in the dimensionality reduction step:

$$
x = \left(x_1,\  x_2,\  \ldots,\  x_N \right)
$$ {#eq:definition-knn-x}

Let $y$ be one of the $M$ samples from the training set (recall that these are labeled with its known correct classes), each with the same shape:

$$
\begin{gathered}
y_m = \left(y_{m,1},\  y_{m,2},\  \ldots,\  y_{m,N} \right)\\
y_m \in \{y_1,\  y_2,\  \ldots,\  y_M\}
\end{gathered}
$$ {#eq:definition-knn-y}

Then, let $d(x,y)$ represent the the Euclidean distance between the two points in $N$-dimensional space, namely:

$$
d(x,y) = \sqrt{\sum\limits_{n=1}^{N} (x_n - y_n)^2}
$$ {#eq:definition-knn-distance}

For each of the test samples $x$ we find the training sample that is closest to it, meaning the $y_p$ that has the minimum distance with respect to $x$:

$$
d(x,y_p) = \text{min } d(x,y_m) \quad m = 1, 2, \ldots, M
$$ {#eq:definition-knn-distance-min}

If _k_ is larger than one, we then repeat the process to find the second-closest training sample and so on until we find all _k_ nearest neighbors to the test sample. The majority class for all those neighbors is then assigned to it.

The classifier will perform differently for different values of _k_. Much like the original paper, we will examine its behavior for several values.

##### Support Vector Machine (SVM)
The other classifier used by @vidal_structural_2020 is the Support Vector Machine. To quote them directly:

>   It is not the purpose of this paper to give a detailed explanation of the SVM classifier. For the interested reader, an excellent detailed review is given in reference \[@smola_tutorial_2004\]. However, to hand over the background and motivation for the proposed methodology, a summary of the method is given. This recap is based on reference \[@vidal_wind_2018\].

The same applies to this work. Rather than patronize readers by parroting here the words of other authors about hyperplanes, convex geometry and topological vector spaces, please refer to the above references for the mathematical background. For our purposes, it is enough to consider the following:

It is relatively feasible to compute in the linear case, meaning it can be applied directly and perform well when the data points are linearly separable or close to it. Naively extending it to nonlinear cases makes it "...computationally infeasible for both polynomial features of higher order and higher dimensionality" [@smola_tutorial_2004].To avoid that pitfall, one can apply the "kernel trick", in which very computationally costly high-dimensional transformations are replaced with a so-called kernel function to be used as an inner product.

The kernel function can be chosen to best fit the shape of the data. @vidal_structural_2020 mention the polynomial (quadratic, cubic, etc.), hyperbolic tangent, and Gaussian radial basis functions and settle on the quadratic kernel as the best fit for the data. Their reasoning is that "it can be seen that \[scatter plots of samples' principal components\] reveal a quadratic relationship and, particularly, the first versus the second feature scatter plot exposes a concentric circles shape of the data set". To follow along with their rationale, [@fig:reproduce-pca-plot] maps our data set in the same fashion.

<div id="fig:reproduce-pca-plot" class="subfigures">
![First versus second principal component.](reproduce-pca-plot-1-vs-2.png){#fig:reproduce-pca-plot-1-vs-2 width=40%}
![First versus third principal component.](reproduce-pca-plot-1-vs-3.png){#fig:reproduce-pca-plot-1-vs-3 width=40%}

![First versus fourteenth principal component.](reproduce-pca-plot-1-vs-14.png){#fig:reproduce-pca-plot-1-vs-14 width=40%}
![First versus twenty-fifth principal component.](reproduce-pca-plot-1-vs-25.png){#fig:reproduce-pca-plot-1-vs-25 width=40%}

Scatter plots of a few principal component pairs. Blue dots are trials from the "healthy" set, while other colors are trials of different damage configurations.
</div>

Note how the results appear different due to using a different data set, but only superficially: not all pairs of principal components match exactly, but their quadratic relationship still shows through. Specifically, [@fig:reproduce-pca-plot-1-vs-2] reveals the exact same shape of concentric circles.

Their chosen quadratic kernel function is as follows:

$$
K(x_i,x_j) = \left(1 + \cfrac{1}{\rho^2}x_i^{\text{T}}x_j \right)^2
$$ {#eq:definition-svm-kernel}

Leaving $\rho$, the kernel scale parameter, as the parameter to tweak to try and fit the behavior of the model to the needs of our data set.

**TODO: mention OvO and OvA (One vs One/All)**

**TODO: in the Results section, add similar PCA plots but coloring by predicted class instead of true class**

#### Cross-validation
The separation of our data set into training and test sets risks an obvious pitfall: what if, by random chance, we end up with a split that is unfairly favorable to the classifiers? What if the reverse is true and the split is unfairly unfavorable? Either is possible: either set could end up with a disproportionate amount of samples that are easier or harder to classify correctly in ways we cannot identify ahead of time, thus skewing the performance results.

In order to dodge this problem @vidal_structural_2020 propose using _k_-fold cross-validation. This involves splitting the data set into _k_ partitions and running the entire model training and classification steps _k_ times: in each cycle, one of the partitions is used as the test set while the rest are combined into a training set.

This leads to _k_ different sets of performance metrics, which are averaged together to obtain the performance metrics for the model as a whole.

@vidal_structural_2020 choose 5-fold cross-validation, as will we in order to replicate their methodology most accurately.

## Proposed improvement
We have just gone over every part of the methodology we aim to replicate. We will now propose an improvement to it, describing both how we will do it and why it is worth doing.

### Data leakage
As explained in @sec:goals-leakage, data leakage is "a spurious relationship between the independent variables and the target variable that arises as an artifact of the data collection, sampling, or pre-processing strategy" [@kapoor_leakage_2023]. It is a broad category of pitfalls that can be encountered in using machine-learning algorithms and which "usually leads to inflated estimates of model performance".

In building a taxonomy of data leakage errors, @kapoor_leakage_2023 list three top-level categories:

>   **\[L1\] Lack of clean separation of training and test dataset.** If the training dataset is not separated from the test dataset during all pre-processing, modeling, and evaluation steps, the model has access to information in the test set before its performance is evaluated.
>
>   **\[L2\] Model uses features that are not legitimate.** If the model has access to features that should not be legitimately available for use in the modeling exercise, this could result in leakage.
>
>   **\[L3\] Test set is not drawn from the distribution of scientific interest.** The distribution of data on which the performance of an ML model is evaluated differs from the distribution of data about which the scientific claims are made.

The original study is safe from category \[L2\]: the only features used by the model are readings from accelerometers attached to the turbine structure, present in both healthy and damaged states. These would also be present in both healthy and damaged turbines in a hypothetical real off-shore park that implemented a similar SHM strategy, so no data leakage there.

It is also safe from category \[L3\], as the claims made it in its conclusions are appropriately narrow and limited to the context of the limited proof of concept:

>   A vibration-response-only methodology has been conceived and a satisfactory experimental proof of concept has been conducted. However, future work is needed to validate the technology in a more realistic environment that takes into account the varying environmental and operational conditions. [@vidal_structural_2020]

It is under the \[L1\] category that we may find instances of data leakage worth avoiding. Let us examine each of the second-level categories under it as described by @kapoor_leakage_2023:

>   **\[L1.1\] No test set.** Using the same dataset for training and testing the model is a textbook example of overfitting, which leads to overoptimistic performance estimates.
>
>   **\[L1.2\] Pre-processing on training and test set.** Using the entire dataset for any pre-processing steps, such as imputation or over/under sampling, results in leakage.
>
>   **\[L1.3\]  Feature selection on training and test set.** Feature selection on the entire dataset results in using information about which feature performs well on the test set to make a decision about which features should be included in the model.

\[L1.1\] can be discarded outright: the methodology described _does_ use separate training and test sets for the classifier, going as far as using _k_-fold cross-validation to avoid overoptimistic estimates due to the choice of split.

We also do not run afoul of \[L1.3\] at any time. There is no after-the-fact feature selection; they are selected from the very beginning and all data gathered from the experiments is used in the model.

Category \[L1.2\], however, arguably includes two aspects of the methodology we have just examined. @vidal_structural_2020 describe separating data into training and test datasets before the classification step and using cross-validation to avoid results being overly determined by the coincidental makeup of each set. However, there is no mention of also enforcing that separation during pre-processing: the scaling and dimensionality reduction steps.

This can lead to the data leakage described in \[L1.2\]: looking at [@eq:column-scaling; @eq:column-scaling-mean; @eq:column-scaling-stdev] the values for $\mu_{k,l}$ and $\sigma_{k,l}$ are obtained from columns of the whole data set and therefore they are a function of the test set (and the training data set, but that is not the problematic part). Each individual scaled value $\breve{x}_{i,j}^{k,l}$ is a function of $\mu_{k,l}$ and $\sigma_{k,l}$ (as well as the original value $x_{i,j}^{k,l}$). Therefore, the scaled values in the training data set are dependent on the values in the test data set — not just because of the underlying physical phenomena we are measuring and attempting to predict, but also because our scaling procedure is leaking data!

The same applies to the dimensionality reduction step: the principal components are chosen using the whole data set, and therefore the transformed values in the training set are dependent on the values in the test set. That's data leakage.

#### Plugging the leaks
Resolving these issues can be achieved by shuffling the steps in our data processing pipeline slightly. Instead of scaling and reducing the entire data set together and then splitting via cross-validation to train and test the classifiers, we first split via cross-validation, scale and reduce the training set in isolation and use it to train the classifiers. Then we take the scaling/reduction parameters (respectively: mean and standard deviation; principal components) obtained from the training set, apply them as-is to the test set and test the classifiers on the result.

**TODO: a diagram of before and after would go a long way here**

#### Scaling
In the scaling step, the scaled value $\breve{x}_{i,j}^{k,l}$ of a reading $x_{i,j}^{k,l}$ is redefined as:

$$
\breve{x}_{i,j}^{k,l} = \cfrac{x_{i,j}^{k,l} - \mu_{k,l}^{\prime}}{\sigma_{k,l}^{\prime}}
$$ {#eq:column-scaling-noleak}

Where $\mu_{k,l}^{\prime}$ is the mean value of all readings in column "$k,l$" that $x$ belongs to, excluding rows that belong to the test set $T$:

$$
\mu_{k,l}^{\prime} = \cfrac{\sum\limits_{i,j}^{(i,j)\notin T} x_{i,j}^{k,l}}{I\cdot J - |T|}
$$ {#eq:column-scaling-noleak-mean}

Likewise, $\sigma_{k,l}^{\prime}$ is the standard deviation of all readings in that same column, excluding rows that belong to the test set $T$:

$$
\sigma_{k,l}^{\prime} = \sqrt{\cfrac{1}{I\cdot J - |T|}\sum\limits_{i,j}^{(i,j)\notin T} (x_{i,j}^{k,l} - \mu_{k,l})^2}
$$ {#eq:column-scaling-noleak-stdev}

Note than in [@eq:column-scaling-noleak-mean; @eq:column-scaling-noleak-stdev] the expression $|T|$ represents the size of the test set.

Note also that the definition in [@eq:column-scaling-noleak] applies to values in both the training and test set: we obtain the mean and standard deviation using only the training set but apply them to both sets. Therefore the scaled test data is dependent on the training data, but not the other way around.

It is worth mentioning that, because the methodology uses 5-fold cross-validation, this revised scaling step will actually run five different times: once for each separate execution of the pipeline performed for each training/test split.

With this slight modification, there is no longer data leakage in the scaling step.

#### Dimensionality reduction
The same principle we followed in the scaling step also applies in the dimensionality reduction step: the principal components are chosen using only the training set, and then they are used to transform both the training and test set. Once again, the reduced test data is dependent on the training data but not the other way around.

The revised dimensionality reduction will, too, run once for each training/test split for a total of five times.

#### Potential impact
It is hard to quantify what the impact of these two changes may have on the performance of the model as a whole without actually going through the motions of implementing them and comparing the results, so that is exactly what we will do.

It is reasonable to expect the classifiers to do at least slightly worse, as data leakage usually leads to overly optimistic results. We shall see if reality agrees with this expectation or if it rudely subverts it.

**TODO: Also talk about code stuff. How did we actually implement the new workflow? Mention [sklearn pipelines](https://scikit-learn.org/stable/modules/generated/sklearn.pipeline.Pipeline.html) and all that good stuff.**

**TODO: total number of tests isn't actually I times J because there's more of the healthy class. gotta go through and fix all the equations lol. maybe just call it N or some other letter**
