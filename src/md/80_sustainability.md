\newpage
# Sustainability analysis
This section will discuss the sustainability and ethical implications of the work as mandated by the Barcelona East School of Engineering's rules on final degree theses.

## Sustainability matrix
The sustainability of this work is to be analyzed following a three by three matrix. We shall discuss three areas of potential impact: environmental, economic and social. For each of those areas we will examine the impact during development, the impact during execution and any supply chain risks and limitations.

### Environmental impact

#### Development
This work was developed entirely using a personal computer at the author's home. There were multiple meetings with the thesis supervisor, but they were all done remotely via video calls, so there are no transportation impacts to account for.

Therefore the only impact to account for is that of the energy consumption of the computer. The final degree thesis is rated at 24 ECTS credits (as in the European Credit Transfer and Accumulation System), which at 25 hours of personal work per credit gives us a figure of 600 hours of work.

Its processor, model AMD Ryzen 5 2600, has a thermal design power of 65W per the manufacturer's specifications [@amd_customer_care_team_amd_nodate]. While the processor accounts for the majority of the power usage of a computer, it is not the only component, so we double it to account for other components and peripherals, bringing us to 130W of power consumption. We then take into account the power supply's efficiency of 80%, resulting in a raw consumption of 162.5W.

According to data aggregated by Electricity Maps [@electricity_maps_leading_nodate], the cabron intensity of electricity generated in Spain was 164g CO~2~eq/kWh on November, 123g CO~2~eq/kWh on October and 127g CO~2~eq/kWh on September for a mean carbon intensity of 138g CO~2~eq/kWh over the period. The working hours were spread unevenly during the day and week due to maintaining full-time employment alongside it, so we will not account for time-of-day differences.

The environmental impact of this work's development can be quantified thusly:

$$
\text{600 hours} \cdot \text{130W} \cdot \cfrac{\text{1kW}}{\text{1000W}} \cdot \cfrac{\text{127g CO\textsubscript{2}eq}}{\text{1kWh}} \cdot \cfrac{\text{1kg}}{\text{1000g}} = \text{9.9kg CO\textsubscript{2}eq emissions}
$$ {#eq:dev-power-usage}

#### Execution and supply chain risks and limitations {#sec:env-impact-execution}
This work does not describe a project to be executed. Even though we describe a methodology that could eventually, given further research and tuning, be applied on the field, we cannot at this point quantify the impact of such a hypothetical effort without overbroad generalizations and essentially pulling numbers out of a hat which would defeat the purpose of such an analysis.

### Economic impact

#### Development
Let us list possible sources of expenses that could have had an economic impact during the development of this work.

No hardware had to be acquired specifically to develop it: an existing personal computer was enough.

The software used was developed specifically for it and relies exclusively on free and open source libraries that are available free of charge, so there was no associated cost other than the author's own time.

There are certainly administrative and personnel costs involved in the enrollment and supervision of a final degree thesis, shared between tuition payments and public funding. Quantifying those is outside the scope of this work, but note that they exist.

The one cost we can quantify is that of the electricity consumed. According to the author's energy bill, the electricity cost was constant (both in the whole time period and across all times of day) at 0.1498728€/kWh tax included. We will not impute power capacity fees to the work because it did not require increasing the already-contracted power capacity. The cost was therefore:

$$
\text{600 hours} \cdot \text{130W} \cdot \cfrac{\text{1kW}}{\text{1000W}} \cdot \cfrac{\text{0.1498728€}}{\text{1kWh}} = \text{11.69€}
$$ {#eq:econ-power-usage}

One should also consider the approximately 600 hours of the author's labor that went into developing the work. We will not assign a monetary value to that.

#### Execution and supply chain risks and limitations
See [@Sec:env-impact-execution].

### Social impact

#### Development {#sec:social-impact-dev}
Leaving aside humorous remarks about the impact of the development on the author's social life, having to research details about the replication crisis and how it relates to problematic ongoing practices in the use of machine-learning in science has been quite illuminating. It is a topic not really covered in the standard Engineering curriculum but with huge implications in both research and practical application of machine-learning techniques.

The author hopes the discussions in [@Sec:goals] may inform the attitudes of readers towards the importance, relevance and intrinsic value of replication and reproduction, and towards the importance of enforcing best practices in the use of machine-learning techniques. At the very least may it serve the members of the examination committee, in their role as researchers and educators; and hopefully through them, their colleagues and students. If the effect goes that far or even beyond then this work will have had a greatly positive social and ethical impact indeed.

Even if that does not happen, the author is still glad to have dug into those issues when setting out the goals for this thesis, and will likely be a better engineer for it.

#### Execution and supply chain risks and limitations
See [@Sec:env-impact-execution].

## Ethical implications
The issues pointed out in [@Sec:social-impact-dev] also belong here, but they are worth stating again so please excuse the repetition.

At first, this work was meant to be a relatively straightforward exercise in aping a technique as used in published research — a way to prove a level of ability and execution sufficient to meet the requirements of a final degree thesis. It was only in the process of researching, justifying and doing the thing that the social and ethical dimension of it all revealed itself. And once it did, one could only pull at that thread and see where it led.

Let that be a valuable lesson to anyone who needs it: it is certainly good to be able to do complicated things and create great works. It is alright to strive for those things. But it is all the more important to keep one's eyes open while doing those things, and keep asking questions like why one is doing them and what wider context they fit into.

The author hopes the discussions in [@Sec:goals] may inform the attitudes of readers towards the importance, relevance and intrinsic value of replication and reproduction, and towards the importance of enforcing best practices in the use of machine-learning techniques. At the very least may it serve the members of the examination committee, in their role as researchers and educators; and hopefully through them, their colleagues and students. If the effect goes that far or even beyond then this work will have had a greatly positive social and ethical impact indeed.

Even if that does not happen, the author is still glad to have dug into those issues when setting out the goals for this thesis, and will likely be a better engineer for it.

It is worth alluding to the ongoing social and ethical debate around "artificial intelligence", particularly around generative models for language and images. While those are indeed very important issues with myriad implications, they have no relevance to this work. We have used existing machine-learning algorithms and applied them to better interpret accelerometer readings from wind turbines. There are no problematic implications to examine there, as there would be if we were instead interpreting or generating personal data, human language, images, footage, etc. or if we had improved techniques in a way that could be directly applied to those fields.

## Relationship with Sustainable Development Goals (SDGs)
Let us discuss how this works relates to the goals set out by the United Nations' 2030 Agenda for Sustainable Development [@united_nations_general_assembly_transforming_2015]. All quotes in this section are sourced from that document.

Because we discuss a procedure that is being proposed at a relatively early proof of concept, using only data from very controlled laboratory experiments, the connection to any SDGs is very tenuous. We have to project ourselves into a hypothetical future where, after years of iteration and improvement and refinement, a similar technique is successfully applied for structural health monitoring of actual offshore wind turbines as part of their regular operation and it leads to a decrease in the human and economic cost of their maintenance operations.

That is a big leap indeed, but it will allow us to go through this thought exercise.

In that context, the work can be said to support Goal 7 "ensure access to affordable, reliable, sustainable and modern energy for all", particularly point 7.2 "by 2030, increase substantially the share of renewable energy in the global energy mix" by making wind power generation more cost effective economically, which incentivizes making it a bigger share of global energi generation.

If we allow ourselves the assumption that better remote sensing may lead to needing fewer maintenance operations, which have inherent risks to workers particularly to the offshore location of these turbines, we could say that by possiblt improving worker safety it supports goal 8 "promote sustained, inclusive and sustainable economic growth, full and productive employment and decent work for all", particularly point 8.8 "Protect labour rights and promote safe and secure working environments for all workers, including migrant workers, in particular women migrants, and those in precarious employment".
