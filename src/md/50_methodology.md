---
subfigGrid: true
lof: true
---
\newpage
# Methodology
<!--  Descripció d’equips i materials utilitzats per a la realització del treball, metodologia emprada i descripció completa dels experiments realitzats -->
What we do and how. Detailed description of all tooling and data used.

## Replication
We replicated a paper. Explain that.

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

### Implementation using open source software
Python libraries rather than MatLab stuff. Some code extracts here and there might help illustrate, relating them to each of the sections above.

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
