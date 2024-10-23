\newpage
# Introduction and goals
<!-- Plantejament del problema, alternatives considerades i objectius a assolir -->
## Introduction
This section will expand on the topics mentioned in the abstract, justifying _why_ the work we're setting out do to is worth doing.

Starting from wide generalities, each subsection should move us closer and closer to the very specific problem we're looking to tackle.

### Wind power today
A couple paragraphs on the role of wind power in today's energy generation, and the increasing importance it's expected to have with the growing focus on renewable energy sources.

000 GW of installed wind power generation capacity as of year XXXX, estimated to be at around 000 GW by year XXXX.

### Offshore wind turbines
Some of that capacity is from offshore wind turbines. What portion? How is it expected to grow?

Briefly discuss the challenges specific to offshore wind turbines. Remoteness, etc. --> it becomes even more important to have good remote sensing capabilities, and good processing techniques to actually use that data.

### Structural Health Monitoring in offshore wind turbines
SHM is a whole thing. Introduce it very briefly, then quickly move on to how it's applied to offshore wind turbines. Big piles of data impossible to parse by humans... luckily math is here to save the day!

### Machine-learning algorithms
May or may not end up removing this subsection. It could be here for a very brief introduction to what machine-learning algorithms _are_, very generally. Only as a way to make the reader's mouth start to water before we move on to the more exciting Methodology section.

## Goals

### Reproducing an existing methodology with new data
Actually properly cite the paper @ https://www.mdpi.com/1424-8220/20/7/1835. Explain how it proposes a methodology to tackle the problem we just defined.

Explain that we're going to try to reproduce its results by applying the same methodology to a new data set. Maybe include a few lines about the importance of reproducibility in science and how the "replication crisis" is a whole thing the scientific community is contending with. All this to justify the existence of this very paper!

### Proposed improvements
Make it clear that we're attempting improvements not in the sense of "the paper did a thing wrong, we're going to do it properly" but in the sense of "wouldn't it be nice to _also_ try this other thing"?

#### Additional classifier(s)

The paper tries out 2 different machine-learning classifiers. We'll try another one, called PLACEHOLDER, and we'll compare its results to those of the other classifiers. For more details, see the Methodology section.

#### Scaling and dimensionality reduction on the training set only

The paper does scaling and dimensionality reduction with the entire data set, then separates it out into training and test data. Only the training data is used to train the classifiers, and then we evaluate how well it does at classifying the test data.

What if we do the training/test split **before** going through scaling and dimensionality reduction? How do the results change? Is it a significant difference? Which variation is closer to how this methodology might be applied on a real system?
