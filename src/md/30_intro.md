\newpage
# Introduction and goals
<!-- Plantejament del problema, alternatives considerades i objectius a assolir -->
## Introduction
Due to their remote location, inspection and maintenance activities on offshore wind turbines are very costly both in terms of risk to workers' health and safety and in economic cost. As worlwide investment on renewable energy sources — including offshore wind turbines — grows, we can expect that toll to increase accordingly unless remedied.

Improved processing of remotely-sensed data can help minimize the number of interventions needed, and thus also the human and economic costs involved: if we can more accurately tell how a structure is doing we don't need people to put themselves at risk by checking in on it in person as often.

**TODO: Maybe some words about how no engineering project, new technique or scientific advancement can be considered in isolation without examining the wider context of the world and the industry it is part of. Pure math/science advancement for the sake of knowledge vs. application of those from an engineering POV. That is why we talk so much about stuff that's unrelated to a strictly mathy data processing problem**

In this section we will first very briefly examine the role of wind power generation and its future trends and the relevance of offshore wind turbines in that wider picture. This will serve to justify _why_ the goals we are setting out to achieve are worth reaching in the first place.

We will then touch on Structural Health Monitoring and how it is applied to offshore wind turbines to decrease their long term operational costs. This will serve to justify _how_ the work we are setting out to do is going to move us closer to that goal.

Lastly we will discuss the role of machine learning algorithms, like the ones this work will examine, in Structural Health Monitoring. This will lay the groundwork for _what_ precisely we intend to work on in later sections.

**TODO: Maybe a subsection about renewables in general before wind power? might be a bit too grandiose**

### The role of wind power
According to the Global Wind Energy Council's 2024 Global Wind Report, wind power generation surpassed 1 TW of total installed capacity in 2023, and it is estimated to reach 2 TW by year 2030 [@lee_global_2024].

According to the European Wind Power Action Plan published by the European Commission [@-european_commission_european_2023], wind power generation capacity in the European Union was 204 GW in 2023. In order to meet its renewable energy generation targets, that number will have to grow that to more than 500 GW by 2030.

It cannot be made any more clear: there is plenty of wind power in the world, and we can rightly expect there to be a lot more in the near future.

### Offshore wind turbines
Some of that capacity is from offshore wind turbines. What portion? How is it expected to grow?

Briefly discuss the challenges specific to offshore wind turbines. Remoteness, etc. --> it becomes even more important to have good remote sensing capabilities, and good processing techniques to actually use that data.

Looking again at the Global Wind Energy Council's 2024 Global Wind Report, global offshore installations add up to 75 GW of installed capacity, a bit over 7% of total wind power generation capacity. Looking at new installations in 2023, offshore ones represent 9% of them — and this share is expected to grow, with offshore wind turbines making up 20% of the capacity of expected new wind power installations in 2028 [@lee_global_2024, p. 151].

In the European Union, the offshore share of installed wind power capacity is 8%, with "ambitious commitments on offshore energy that amount to 111 GW across all EU sea basins by 2030" [@european_commission_european_2023] which, when accounting for the total wind power target for 2030, would work out to over 20% of capacity belonging to offshore installations.

In other words: offshore wind turbines are already, today, a very significant part of wind power generation. According to industry estimates, its importance will become even larger in the near future. That is why it is not only useful, but _essential_, to closely examine the risks and costs involved in their daily operations and maintenance to mitigate human and economic costs as much as possible.

### Structural Health Monitoring in offshore wind turbines
Structural Health Monitoring can be defined as a strategy that "aims to give, at every moment during the life of a structure, a diagnosis of the 'state' of the constituent materials, of the different parts, and of the full assembly of these parts constituting the structure as a whole" [@balageas_structural_2010].

Its prototypical form is a set of sensors that measure physical phenomena (such as acceleration or temperature) and a controller that takes all their signals and reduces them to a diagnosis — whether the structure healthy or damaged. One can design such a system to go beyond the healthy/damaged dichotomy, and instead report a more fine grained diagnosis: what is the nature of the detected damage? Is it bad enough to necessitate immediate intervention, or can repairs be postponed until regular maintenance operations?

Such monitoring strategies can go from the very simple to the unimaginably complex. Let us imagine, for example, a trivially simple case: monitoring the state of a car's tires with four pressure sensors, one for each. If the sensed pressure for a wheel falls within an acceptable range as defined by the car's manufacturer, then it is in a healthy state. If it is above that range, the tire is overinflated. If it is below, it is underinflated. If the pressure reading is at zero (relative to atmospheric pressure) then the tire has blown out. Therefore we can diagnose each tire as being healthy or in one of three damaged states using a controller that simply compares one signal's to predetermined values. The computational complexity of this strategy is essentially null; a human technician could very easily apply it.

Moving up a few steps in complexity, consider the monitoring of unidirectional fiber composite laminates via electrical resistance as described by @balageas_structural_2010 [ch. 5]. These materials exhibit piezoresistivity, meaning their electrical resistance changes as mechanical stress is applied to them. Once a particular element's stress-strain-electrical resistance characteristic is determined, one could use sensors to monitor for changes in that characteristic, which would indicate fractures in its microscopic fibers and alert to damage before catastrophic failure. This would require a more sophisticated controller than the earlier simple "compare-single-value" case.

Turning up the difficulty even higher we reach the matter at hand: Structural Health Monitoring in offshore wind turbines. These are large structures made of many different elements and exposed to constantly changing and chaotic stresses due to varying atmospheric and sea conditions. Their state cannot be measured by single values like a tire's pressure or a composite's electrical resistance. All one can do is attach several accelerometers at different points on the structure, resulting in thousands upon thousands of readings per second that need to be somehow reduced to a single diagnosis.

To the human eye, such readings are impossible to decipher — too much data with entirely too much noise mixed in. With tried and true mathematical methods for dimensionality reduction it is possible to condense the data down to a more workable form, but even that does not open an easy path to diagnosis: the forces applied to the structure and its response to them is extremely specific to a particular wind turbine in a particular park in a particular place in the world at a particular time and date. There is no simple model or physical law that can answer the question "is this structure healthy?" from the accelerometer data.

Enter machine learning algorithms, which enable precisely the kind of pattern recognition needed for this problem. They provide the "mathematical means of associating measured data with given class labels" [@farrar_structural_2012, p. 8] without the need to actually model the system that is generating the measured data: it is enough to provide training data along with known correct class labels (e.g. this is data from a healthy structure, this is data from a damaged structure) and the algorithms are able to find the relevant features and apply them to classify data it has never encountered before.

**TODO: [@devriendt_structural_2014] has applied SHM to actual offshore wind turbines, maybe worth pointing at it somewhere**

## Goals

### Reproducing an existing methodology with new data
Explain how @vidal_structural_2020 proposes a methodology to tackle the problem we just defined.

Explain that we're going to try to reproduce its results by applying the same methodology to a new data set. Maybe include a few lines about the importance of reproducibility in science and how the "replication crisis" is a whole thing the scientific community is contending with. All this to justify the existence of this very paper!

### Proposed improvements
Make it clear that we're attempting improvements not in the sense of "the paper did a thing wrong, we're going to do it properly" but in the sense of "wouldn't it be nice to _also_ try this other thing"?

#### Additional classifier(s)

The paper tries out 2 different machine-learning classifiers. We'll try another one, called PLACEHOLDER, and we'll compare its results to those of the other classifiers. For more details, see the Methodology section.

#### Scaling and dimensionality reduction on the training set only

The paper does scaling and dimensionality reduction with the entire data set, then separates it out into training and test data. Only the training data is used to train the classifiers, and then we evaluate how well it does at classifying the test data.

What if we do the training/test split **before** going through scaling and dimensionality reduction? How do the results change? Is it a significant difference? Which variation is closer to how this methodology might be applied on a real system?
