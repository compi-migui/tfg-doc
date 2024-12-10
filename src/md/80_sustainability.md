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

According to data aggregated by Electricity Maps [@electricity_maps_leading_nodate], the cabron intensity of electricity generated in Spain was 164g CO_2eq/kWh on November, 123g CO_2eq/kWh on October and 127g CO~2~eq/kWh on September for a mean carbon intensity of 138g CO~2~eq/kWh over the period. The working hours were spread unevenly during the day and week due to maintaining full-time employment alongside it, so we will not account for time-of-day differences.

The environmental impact of this work's development can be quantified thusly:

$$
600 \text{hours} \cdot 130 \text{W} \cdot \cfrac{1 \text{kW}}{1000 \text{W}} \cdot \cfrac{127 \text{g CO~2~}}{1 \text{kWh}} \cdot \cfrac{1 \text{kg}}{1000 \text{g}} = 9.9 \text{kg CO~2~eq emissions}
$$ {#eq:dev-power-usage}

#### Execution and supply chain risks and limitations {#sec:env-impact-execution}
This work does not describe a project to be executed. Even though we describe a methodology that could eventually, given further research and tuning, be applied on the field, we cannot at this point quantify the impact of such a hypothetical effort without overbroad generalizations and essentially pulling numbers out of a hat which would defeat the purpose of such an analysis.

>   we can say it "helps" wind power/renewable energy stuff by potentially making it cheaper to operate thus incentivizing it

### Economic impact

#### Development
Let us list possible sources of expenses that could have had an economic impact during the development of this work.

No hardware had to be acquired specifically to develop it: an existing personal computer was enough.

The software used was developed specifically for it and relies exclusively on Free and Open Source libraries that are available free of charge, so there was no associated cost other than the author's own time.

There are certainly administrative and personnel costs involved in the enrollment and supervision of a final degree thesis, shared between tuition payments and public funding. Quantifying those is outside the scope of this work, but note that they exist.

The one cost we can quantify is that of the electricity consumed. According to the author's energy bill, the electricity cost was constant (both in the whole time period and across all times of day) at 0.1498728€/kWh tax included. We will not impute power capacity fees to the work because it did not require increasing the already-contracted power capacity. The cost was therefore:

$$
600 \text{hours} \cdot 130 \text{W} \cdot \cfrac{1 \text{kW}}{1000 \text{W}} \cdot \cfrac{0.1498728 \text{€}}{1 \text{kWh}} = 11.69 \text{€}
$$ {#eq:econ-power-usage}

#### Execution and supply chain risks and limitations
>   we can say it "helps" wind power/renewable energy stuff by potentially making it cheaper to operate thus incentivizing it

### Social impact

#### Development

#### Execution and supply chain risks and limitations
>   we can say it "helps" wind power/renewable energy stuff by potentially making it cheaper to operate thus incentivizing it (climate change)

>   we can say it "helps" reduce the human cost of blah because detecting issues remotely means fewer dangerous in-person interventions for unforeseen emergencies. huge astersisks though

## Ethical implications
>   mention ongoing big ethical social debate around "AI" stuff but that none of it applies to this application of good ol' ML

## Relationship with Sustainable Development Goals

>   cite https://sdgs.un.org/goals
