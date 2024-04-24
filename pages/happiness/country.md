---
queries:
  - hs_archive: happiness/hsArchive.sql
  - hs2024: happiness/hs2024.sql
  - regional: happiness/getRegionCategory.sql
---

```sql hs_archive_country
SELECT *
FROM   ${hs_archive}
WHERE  country = '${inputs.country.value}'
```

```SQL get_country
SELECT    a.country,
          a.rank,
          a.score,
          a.ebgdp                  AS "GDP",
          a.ebsocialsupport        AS "Social Support",
          a.eblifeexpectancy       AS "Life Expectancy",
          a.ebfreedomoflifechoices AS "Freedom Of Life Choices",
          a.ebgenerosity           AS "Generosity",
          a.ebcorruption           AS "Corruption",
          a.dystopiaresidual       AS "Dystopia + Residual",
          CASE
                    WHEN b.score IS NULL THEN 0
                    ELSE ((a.score - b.score) / b.score)
          END AS deltascore
FROM      ${hs2024} a
LEFT JOIN ${hs_archive} b
ON        a.country = b.country
WHERE     year(b.scoreyear)=2023
AND       b.country IN ('${inputs.country.value}')
```

```sql happiness_year
SELECT scoreyear
FROM   ${hs_archive}
WHERE  country='${inputs.country.value}'
AND    score =
       (
        SELECT max(score)
        FROM   ${hs_archive}
        WHERE  country='${inputs.country.value}'
       )
```

# Coutnry-wise happiness

Select a country to begin: <Dropdown data={hs2024} name=country value=country order=country> <DropdownOption valueLabel="Select A Country" value="" /></Dropdown>

{#if inputs.country.value != ""}

<center>
<BigValue
data={get_country}
title="Rank"
value=rank
/>

<BigValue
title={inputs.country.value + " Happiness Score"}
data={get_country}
value=score
comparison=deltascore
comparisonFmt=pct1
comparisonTitle="from 2023"/>

<BigValue
data={happiness_year}
title={"Happiest year for " + inputs.country.value}
value=scoreYear
fmt=yyyy
/>

### Composition of Happiness Score (evaluated factors)

<BigValue
data={get_country}
title="GDP per capita"
value="GDP"/>

<BigValue
data={get_country}
title="Social Support"
value="Social Support"/>

<BigValue
data={get_country}
title="Life Expectancy"
value="Life Expectancy"/>

<BigValue
data={get_country}
title="Freedom Of Life Choices"
value="Freedom Of Life Choices"/>

<BigValue
data={get_country}
title="Generosity"
value="Generosity"/>

<BigValue
data={get_country}
title="Corruption"
value="Corruption"/>

<BigValue
data={get_country}
title="Dystopia + Residual"
value="Dystopia + Residual"/>

</center>

<LineChart
data={hs_archive_country}
x=scoreYear
xFmt=yyyy
y=score
yFmt=num3
yScale=true
yGridlines=false
yAxisLabels=false
markers=true
markerShape=emptyCircle
title="Happiness Score Over Time"
labels=true>
<ReferenceArea xMin='2020' xMax='2022' label="Covid-19" color=red/>
</LineChart>

### Select a factor to see its trend: <Dropdown name=factor><DropdownOption value="gdpPerCapita" valueLabel="GDP per capita"/> <DropdownOption value="socialSupport" valueLabel="Social Support"/> <DropdownOption value="healtyLifeExpectancyAtBirth" valueLabel="Life Expectancy"/> <DropdownOption value="freedomToMakeLifeChoices" valueLabel="Freedom Of Life Choices"/> <DropdownOption value="generosity" valueLabel="Generosity"/> <DropdownOption value="perceptionsOfCurrotpion" valueLabel="Corruption"/> </Dropdown>

{#if inputs.factor.value != ""}
<LineChart
data={hs_archive_country}
x=scoreYear
xFmt=yyyy
y={inputs.factor.value}
yFmt=num3
yScale=true
yGridlines=false
yAxisLabels=false
markers=true
markerShape=emptyCircle
labels=true>
<ReferenceArea xMin='2020' xMax='2022' label="Covid-19" color=red/>
</LineChart>
{/if}
{/if}
