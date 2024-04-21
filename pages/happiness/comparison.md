---
queries:
  - hs2024: happiness/hs2024.sql
  - yearly_scores: happiness/getYearlyScores.sql
---

```sql getComparison
SELECT country,
       score,
       ebGDP                  AS "GDP",
       ebSocialSupport        AS "Social Support",
       ebLifeExpectancy       AS "Life Expectancy",
       ebFreedomOfLifeChoices AS "Freedom Of Life Choices",
       ebGenerosity           AS "Generosity",
        ebCorruption           AS "Corruption",
        dystopiaResidual       AS "Dystopia Residual"
FROM   ${hs2024}
WHERE  country IN ('${inputs.home.value}','${inputs.away.value}')
```

```sql getHistory
SELECT a.country,
       a.score,
       CASE
                    WHEN b.score IS NULL THEN 0
                    ELSE ((a.score - b.score) / b.score)
       END AS change
FROM   happiness_score.hs2024 a
LEFT JOIN   happiness_score.hsArchive b
ON     a.country = b.country
WHERE  a.country IN ('${inputs.home.value}','${inputs.away.value}') AND year(b.scoreyear)=2023
```

```sql getHomeHistory
SELECT * FROM happiness_score.hsArchive WHERE country = '${inputs.home.value}'
```

```sql getAwayHistory
SELECT * FROM happiness_score.hsArchive WHERE country = '${inputs.away.value}'
```

## Select two countries to compare their happiness scores

<center>
<Dropdown data={hs2024} name=home value=country order=country>
<DropdownOption valueLabel="Select A Country" value="" />
</Dropdown>
<Dropdown data={hs2024} name=away value=country order=country>
<DropdownOption valueLabel="Select A Country" value="" />
</Dropdown>
</center>

{#if inputs.home.value != "" && inputs.away.value != ""}

<center>

<BigValue
data={getHistory[0]}
comparisonFmt=pct1
value=score
comparison=change
title={inputs.home.value + " Happiness Score"}
comparisonTitle="from 2023"
/>

<BigValue
data={getHistory[1]}
value=score
title={inputs.away.value + " Happiness Score"}
comparison=change
comparisonFmt=pct1
comparisonTitle="from 2023"
/>

</center>

<BarChart
data={getComparison}
x=country
y={["GDP", "Social Support", "Life Expectancy", "Freedom Of Life Choices", "Generosity", "Corruption", "Dystopia Residual"]}
swapXY=true
labels=true
yGridlines=false
yAxisLabels=false
yMin=0
/>

<center>
<Dropdown name=factor>
<DropdownOption value="gdpPerCapita" valueLabel="GDP per capita"/>
<DropdownOption value="socialSupport" valueLabel="Social Support"/>
<DropdownOption value="healtyLifeExpectancyAtBirth" valueLabel="Life Expectancy"/>
<DropdownOption value="freedomToMakeLifeChoices" valueLabel="Freedom Of Life Choices"/>
<DropdownOption value="generosity" valueLabel="Generosity"/>
<DropdownOption value="perceptionsOfCurrotpion" valueLabel="Corruption"/>
</Dropdown>
</center>

<LineChart
data={getHomeHistory}
x=scoreYear
xFmt=yyyy
y={inputs.factor.value}
yFmt=num2
yScale=true
yGridlines=false
yAxisLabels=false
markers=true
markerShape=emptyCircle
labels=true
title = {inputs.home.value + " - " + inputs.factor.label}>
<ReferenceArea xMin='2020' xMax='2022' label="Covid-19" color=red/>
</LineChart>

<LineChart
data={getAwayHistory}
x=scoreYear
xFmt=yyyy
y={inputs.factor.value}
yFmt=num2
yScale=true
yGridlines=false
yAxisLabels=false
markers=true
markerShape=emptyCircle
labels=true
title = {inputs.away.value + " - " + inputs.factor.label}>
<ReferenceArea xMin='2020' xMax='2022' label="Covid-19" color=red/>
</LineChart>

{/if}
