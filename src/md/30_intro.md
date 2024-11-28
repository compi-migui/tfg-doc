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

**TODO: would be nice to talk more about OWT maintenance operations here, quantify that human/econ cost we're trying to minimize**

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

### Replicating an existing methodology with new data
@vidal_structural_2020 proposed an approach to processing accelerometer data from offshore wind turbines for the purpose of Structural Health Monitoring. We are going to take their methodology and attempt to replicate their results by applying it to a different data set.

The data set we will use was created by @leon_medina_online_2023 using the same experimental setup (meaning, the same physical model and sensors) for the purposes of defining alternative approaches to the same problem. This is ideal for our purposes because it means we have data similar enough to that used by @vidal_structural_2020 that it can be reasonably expected that their results can be replicated, but without being a simple one to one repeat of what they already did.

One might ask, what is the purpose of that? Why bother replicating the results of an existing work? Answering that question requires at least some discussion on the principles behind the scientific method, the role reproduction and replication play in it, the Replication Crisis and how it relates to the field of Machine Learning.

At its core, the scientific method involves coming up with falsifiable hypotheses that are then put to the test via experimentation. The results of those experiments are analyzed to determine whether they support the hypotheses, allowing us to refine our understanding of an aspect of the world. The approach can be applied to all sorts of questions one can come up with in all sorts of fields, like "does the Moon exist?" (most signs point to yes) or "can you use a Pozidriv screwdriver on a Phillips head screw?" (you can in a pinch, but the screw will suffer for it).

Since it is all about improving our collective understanding of the world, it is _crucial_ that such results be replicable by others in the scientific community. That is the only to verify their correctness — not simply to spot actual mistakes made by the original researchers or flukes introduced by random chance, but to further refine our understanding through iteration and thus inch forwards toward progressively more accurate knowledge and better technique.

This is where we must pull up our sleeves and define some terminology. What does it mean to be able to replicate or reproduce existing research? What's the difference between the three terms? Unfortunately, the answer is "it depends". Looking at publications across several fields, @barba_terminologies_2018 found that "they either, A—make no distinction between the words reproduce and replicate, or B—use them distinctly. If B, then they are commonly divided in two camps. In a spectrum of concerns that starts at a minimum standard of 'same data+same methods=same results,' to 'new data and/or new methods in an independent study=same findings,' group 1 calls the minimum standard reproduce, while group 2 calls it replicate. This direct swap of the two terms aggravates an already weighty issue". Indeed a sorry state of affairs.

So, rather than starting with our term of choice, let us build up to it using the following underlying concepts:

>   Regardless of the specific terms used, the underlying concepts have long played essential roles in all scientific disciplines. These concepts are closely connected to the following general questions about scientific results:
>
>   -  Are the data and analysis laid out with sufficient transparency and clarity that the results can be checked?
>
>   -  If checked, do the data and analysis offered in support of the result in fact support that result?
>
>   -  If the data and analysis are shown to support the original result, can the result reported be found again in the specific study context investigated?
>
>   -  Finally, can the result reported or the inference drawn be found again in a broader set of study contexts?
>
>   \ — @national_academies_of_sciences_engineering_and_medicine_reproducibility_2019 [p. 44]

Our goal is to answer the third question above: "can the result reported be found again in the specific study context investigated?". We will not have access to the data and code used by @vidal_structural_2020 and instead we will do our best to apply their methodology as laid out in their paper. We will call this **replication**. If we can replicate their results, then their work is replicable. If we cannot, then either their work is not replicable or we failed in our efforts.

Rather than stopping there, we will in turn provide all our data **TODO: !!! ask @leon_medina_online_2023 if they actually allow this, since it's their data !!!** and code such that anyone asking the first and second questions about our work will find that the answer is yes to both. This is what we will call **reproducibility**: anyone will be able to use our code to derive the same results from the data, so our work will be reproducible.

These definitions for replicability and reproducibility match the ones used by the @national_academies_of_sciences_engineering_and_medicine_reproducibility_2019 and identified as "broadly disseminated across disciplines" by @barba_terminologies_2018. Beware that, as mentioned earlier, the two are not used consistently across disciplines and even less so in popular discourse.

Having defined these terms and going back to the importance of replicability, perhaps the best known example is the so-called Replication Crisis, a phenomenon widely reported over the last decade and change in which many published and peer-reviewed scientific papers turned out to not be replicable at all. As a surface level example, @shrout_psychology_2018 mentions "the effort by the Open Science Collaboration to replicate 100 results that were systematically sampled from three top-tier journals in psychology: (_a_) Only 36% of the replication efforts yielded significant findings, (_b_) 32% of the original findings were no longer significant when combined with the new data, (_c_) effect sizes in the replication studies were about half the size of those in the original studies, and (_d_) failures to replicate were related to features of the original study (e.g., replication failures were more common in social than in cognitive psychological studies and in studies reporting surprising rather than intuitive findings)".

While the Replication Crisis first came up in the context of the field of psychology, it has brought to the foreground replicability and reproducibility issues in other social and natural sciences. Perhaps most relevant to this work, @kapoor_leakage_2023 discuss how the usage of Machine learning adds fuel to this fire, surveying "22 papers that identify pitfalls in the adoption of ML methods across 17 fields, collectively affecting 294 papers" which together with the lack of "systemic solutions that have been deployed for these failures" they argue supports the view "that ML-based science is suffering from a reproducibility crisis".

To wrap up the topic, we simply cannot discuss the issues without at least briefly mentioning potential causes. In the context of the field of psychology, @lilienfeld_psychologys_2017 confronts the impact of what he calls "grant culture", wherein the methods of allocation of research funding and the pressures exerted by employing institutions on researchers to obtain that funding (both positive "e.g., tenure, promotion, awards, salary increases, resources" and negative "e.g., threats of being denied tenure and promotion, loss of laboratory space and graduate student access") leads to several negative consequences, among them:

>   "Disincentives for conducting direct replications. Until recently, major federal agencies have allocated relatively little funding to supporting direct replications of previous work. Hence, there is scant incentive for investigators to replicate others’ work. In this respect, the grant culture often works against the accumulation of reproducible knowledge."
>   \ — @lilienfeld_psychologys_2017

As an outsider, the author of this work can hardly argue in favor or against that interpretation, but it rings valid as a systemic cause leading to systemic problems. Either way, and fortunately, those disincentives are not present in the context of a Final Thesis for an undergraduate degree. So let us take advantage of the opportunity and do some replication.

### Proposed improvement: avoiding data leakage
In discussing what they call a reproducibility crisis in machine-learning-based science, @kapoor_leakage_2023 define data leakage as "a spurious relationship between the independent variables and the target variable that arises as an artifact of the data collection, sampling, or pre-processing strategy" and they build a taxonomy of data leakage errors.

One of those is of particular relevance to us:

>   **\[L1\] Lack of clean separation of training and test dataset.** If the training dataset is not separated from the test dataset during all pre-processing, modeling, and evaluation steps, the model has access to information in the test set before its performance is evaluated. Because the model has access to information from the test set at training time, the model learns relationships between the predictors and the outcome that would not be available in additional data drawn from the distribution of interest. The performance of the model on these data therefore does not reflect how well the model would perform on a new test set drawn from the same distribution of data. This can happen in several ways, such as:
>   ...
>   **\[L1.2\] Pre-processing on training and test set.** Using the entire dataset for any pre-processing steps, such as imputation or over/under sampling, results in leakage.
>   \ — @kapoor_leakage_2023 [p. 4]

In their methodology, @vidal_structural_2020 describe separating data into training and test datasets before the classification step and using cross-validation to avoid results being overly determined by the coincidental makeup of each set. However, there is no mention of also enforcing that separation during pre-processing: the scaling and dimensionality reduction steps.

This could arguably lead to the data leakage described by @kapoor_leakage_2023: the scaling and dimensionality reduction applied to the training set is informed by the contents of the test set. If the training set was instead scaled and reduced in isolation, the classifiers trained on it would be comparatively less suited to handling the data in the (also pre-processed in isolation, but using the same scaling and vectorial space as the training set) test set — which is the point of keeping them separate in the first place.

Note that this is not necessarily a mistake nor does it invalidate the obtained results. It is quite likely that the difference between the two approaches is insignificant in this instance. But we do not need to guess: after we have replicated the original methodology, we will also use a modified methodology in which we will apply the strict separation during pre-processing as advised by @kapoor_leakage_2023.

With both sets of results we will be able to determine whether there was data leakage that altered the results significantly.
