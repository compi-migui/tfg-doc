\newpage
# State of the art
<!-- Estudi de l’estat actual sobre el problema plantejat, en funció de tècnica, processos, metodologies, alternatives, etc. -->
The field of structural health monitoring is vast and varied. In an entire tome dedicated to cataloguing the state of the art, @balageas_structural_2010 [p. 32-36] lists a staggering amount of types of sensors, monitoring techniques and fields they are applied to. And that is before accounting for the developments in the decade and a half since.

Rather than attempting to cover the entire field and end up with a description a mile wide and an inch deep, let us instead be brief and focus on areas of immediate relevance to this work.

Structural health monitoring (SHM) is a strategy that "aims to give, at every moment during the life of a structure, a diagnosis of the 'state' of the constituent materials, of the different parts, and of the full assembly of these parts constituting the structure as a whole" [@balageas_structural_2010].

It can be applied to different constituent parts of offshore wind turbines. For example, @antoniadou_aspects_2015 discuss SHM techniques applied to detecting damage in turbine gearboxes and blades, "because it has been observed that these components have the most frequent failures and can cause the highest downtime in a wind turbine". However, as they rightly point out, "there is no limitation in the application of the methods to different components."

Our intention here is to cover one of those "different components": we aim to detect damage not in turbine gearboxes and blades, but instead in the structures that support the whole turbine on the seabed. While the monitoring of either falls under the SHM umbrella, each presents its own challenges — different failure modes, sensors best suited to the task, signal processing techniques and so on.

We cannot hope to list all the techniques that have been applied to this problem, but let us mention some to illustrate their variety.

@perez_damage_2017 used the damage submatrices method, where the geometry of the healthy structure is reconstructed as a set of stiffness matrices which, together with measured frequency response of the actual structure (or rather, a finite element model of it, no actual physical structure was used in the study), can be used to detect damage.

@tewolde_validated_2017 took real data from accelerometers, inclinometers, strain gauges and grout sensors installed on an actual offshore wind turbine. They used operational modal analysis to extract mechanical characteristics of the structure and build a finite element model of it, then progressively added damage to the model and examined how those mechanical characteristics changed as a result. This could be applied to an actual structure: measure the healthy state, see how it changes over time compared to different modeled damage conditions.

@haeri_inverse_2017 is another example of these approaches that rely on modeling the actual structure and its mechanical characteristics to gauge its healthiness.

@vidal_structural_2020 take a different approach: while the accelerometer data they use is gathered from a physical scale model of a structure, they do not attempt to measure or derive (at least not explicitly) its mechanical characteristics. Instead they gather data from both healthy and damaged states and rely on the capability of machine-learning algorithms to train on data with know correct labels to classify unlabeled (from the point of view of the algorithm) data sets as belonging to the healthy class or to one of four classes of different damage types. Theirs is the methodology that we intent to replicate.

A similar approach is used by @leon_medina_online_2023, who instead of offline classification algorithms, which need to process closed data sets all at once, they use online ones, which can be trained incrementally sample by sample. The data set they generate is the one used in this work.

On practical real-world applications, @weijtjens_vibration_2017 discuss the installation of vibration monitoring systems (using accelerometers) on a total of 5 offshore wind turbines and the ways that the data they collected provide insight into the state of the support structure (as well as the turbine blades). Two of the monitored turbines used jacket foundations, much like the experimental model we examine.

On the economic feasibility of these monitoring strategies, @martinez-luengo_guidelines_2019 evaluated their impact on both the capital and operational expenditure of wind farms. They ran a cost-benefit analysis and concluded that implementing them increases capital expenditure by less 0.1% while reducing operational expenditure by an estimated 0.2-1.5%, and that "the added value of SHM implementation was estimated to be between 1.93–18.11 M€ for the presented scenarios and sensitivity analyses".

@vieira_insights_2022 took a different approach to judging the effect of offshore wind support structures SHM, using "real data regarding average cadencies of a certain failure" to create a Monte Carlo model which they used to simulate the impact of implementing those strategies. They concluded that:

>   Results obtained from the three tested scenarios quantify the relationship between greater detection efficiencies of the monitoring system (SHME) and lower intervals between inspections (IbI), which result in higher farm production throughout the operational lifetime of the farm, as well as in larger confidence in the expected farm output

In short, structural health monitoring of offshore wind turbines is a problem that is being approached from multiple directions at once. It has demonstrated practical application and easily passes cost-benefit analyses, so it is decidedly very relevant from an engineering point of view rather than being a purely academic pursuit.
