---
queries:
  - hs2024: happiness/hs2024.sql
  - yearly_scores: happiness/getYearlyScores.sql
---

```sql getComparison
SELECT country,
       score,
       ebgdp                  AS "GDP",
       ebsocialsupport        AS "Social Support",
       eblifeexpectancy       AS "Life Expectancy",
       ebfreedomoflifechoices AS "Freedom Of Life Choices",
       ebgenerosity           AS "Generosity",
       ebcorruption           AS "Corruption",
       dystopiaresidual       AS "Dystopia Residual"
FROM   ${hs2024}
WHERE  country IN ('${inputs.home.value}',
                   '${inputs.away.value}')
```

```sql getHomeScore
SELECT a.country,
       a.score,
       CASE
         WHEN b.score IS NULL THEN 0
         ELSE ( ( a.score - b.score ) / b.score )
       END AS change
FROM   happiness_score.hs2024 a
       LEFT JOIN happiness_score.hsarchive b
              ON a.country = b.country
WHERE  a.country IN ( '${inputs.home.value}')
       AND Year(b.scoreyear) = 2023
```

```sql getAwayScore
SELECT a.country,
       a.score,
       CASE
         WHEN b.score IS NULL THEN 0
         ELSE ( ( a.score - b.score ) / b.score )
       END AS change
FROM   happiness_score.hs2024 a
       LEFT JOIN happiness_score.hsarchive b
              ON a.country = b.country
WHERE  a.country IN ( '${inputs.away.value}')
       AND Year(b.scoreyear) = 2023
```

```sql getHistory
SELECT a.scoreYear,
       MAX(CASE WHEN a.country = '${inputs.home.value}' THEN a.${inputs.factor.value} ELSE NULL END) AS '${inputs.home.value}_${inputs.factor.value}',
       MAX(CASE WHEN b.country = '${inputs.away.value}' THEN b.${inputs.factor.value} ELSE NULL END) AS '${inputs.away.value}_${inputs.factor.value}',
       MAX(CASE WHEN a.country = '${inputs.home.value}' THEN a.score ELSE NULL END) AS '${inputs.home.value}_score',
       MAX(CASE WHEN b.country = '${inputs.away.value}' THEN b.score ELSE NULL END) AS '${inputs.away.value}_score'
FROM   happiness_score.hsarchive a
       FULL JOIN happiness_score.hsarchive b ON a.scoreYear = b.scoreYear AND b.country = '${inputs.away.value}'
WHERE  a.country = '${inputs.home.value}'
GROUP BY a.scoreYear
```

## Select two countries to compare their happiness scores

<center>
<Dropdown data={hs2024} name=home value=country order=country defaultValue="India">
<DropdownOption valueLabel="Select A Country" value="" />
</Dropdown>
<Dropdown data={hs2024} name=away value=country order=country defaultValue="Bangladesh">
<DropdownOption valueLabel="Select A Country" value="" />
</Dropdown>
</center>

{#if inputs.home.value != "" && inputs.away.value != ""}

<center>

<BigValue
data={getHomeScore}
comparisonFmt=pct1
value=score
comparison=change
title={inputs.home.value + " Happiness Score"}
comparisonTitle="from 2023"
/>

<BigValue
data={getAwayScore}
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

<LineChart
data={getHistory}
x=scoreYear
xFmt=yyyy
y={[inputs.home.value + "_score", inputs.away.value + "_score"]}
yFmt=num2
yScale=true
yGridlines=false
yAxisTitle=false
markers=true
markerShape=emptyCircle>
<ReferenceArea xMin='2020' xMax='2022' label="Covid-19" color=red/>
</LineChart>

### Select a factor to see how it has changed over the years

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
data={getHistory}
x=scoreYear
xFmt=yyyy
y={[inputs.home.value + "_" + inputs.factor.value, inputs.away.value + "_" + inputs.factor.value]}
yFmt=num2
yScale=true
yGridlines=false
yAxisTitle=false
markers=true
markerShape=emptyCircle>
<ReferenceArea xMin='2020' xMax='2022' label="Covid-19" color=red/>
</LineChart>

{/if}
