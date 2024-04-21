---
queries:
  - hs_archive: happiness/hsArchive.sql
  - hs2024: happiness/hs2024.sql
  - regional: happiness/getRegionCategory.sql
---

```sql regionalcategorycount
SELECT region, category, COUNT(*) as count FROM ${regional} GROUP BY category, region
```

```sql top3
SELECT
    a.country,
    ROUND(a.score, 2) AS score,
    CASE
        WHEN b.score <> 0 THEN ((a.score - b.score) * 1.0 / b.score)
        ELSE NULL
    END AS deltascore
FROM
    ${hs2024} a
JOIN
    ${hs_archive} b
ON
    a.country = b.country AND YEAR(b.scoreYear) = 2023
ORDER BY
    a.score DESC
LIMIT 3
```

```sql bottom3
SELECT
    a.country,
    ROUND(a.score, 2) AS score,
    CASE
        WHEN b.score <> 0 THEN ((a.score - b.score) * 1.0 / b.score)
        ELSE NULL
    END AS deltascore
FROM
    ${hs2024} a
JOIN
    ${hs_archive} b
ON
    a.country = b.country AND YEAR(b.scoreYear) = 2023
ORDER BY
    a.score
LIMIT 3
```

```sql avg2024
SELECT
    '2024' AS scoreYear,
    AVG(score) AS avg
FROM
    ${hs2024}
```

```sql yearlyAvgTrend
SELECT
    YEAR(scoreYear) AS year,
    AVG(score) AS avg
FROM
    ${hs_archive}
GROUP BY
    scoreYear
UNION ALL
SELECT*
FROM
    ${avg2024}
ORDER BY
    scoreYear
```

# World Happiness stats

## World average of 2024 is <Value data={avg2024} row=0 column=avg fmt=number precision=2/>

<center>

### <ins>Top 3</ins>

<Grid cols=3>
<BigValue data={top3[0]} title={"Rank 1 ("+ top3[0].score +")"} value=country comparison=deltascore comparisonFmt=pct1 comparisonTitle="score vs. 2023"/>
<BigValue data={top3[1]} title={"Rank 2 ("+ top3[1].score +")"} value=country comparison=deltascore comparisonFmt=pct1 comparisonTitle="score vs. 2023"/>
<BigValue data={top3[2]} title={"Rank 3 ("+ top3[2].score +")"} value=country comparison=deltascore comparisonFmt=pct1 comparisonTitle="score vs. 2023"/>
</Grid>

### <ins>Bottom 3</ins>

<Grid cols=3>
<BigValue data={bottom3[0]} title={"Rank 143 ("+ bottom3[0].score +")"} value=country comparison=deltascore comparisonFmt=pct1 comparisonTitle="score vs. 2023"/>
<BigValue data={bottom3[1]} title={"Rank 142 ("+ bottom3[1].score +")"} value=country comparison=deltascore comparisonFmt=pct1 comparisonTitle="score vs. 2023"/>
<BigValue data={bottom3[2]} title={"Rank 141 ("+ bottom3[2].score +")"} value=country comparison=deltascore comparisonFmt=pct1 comparisonTitle="score vs. 2023"/>
</Grid>

</center>

# Happiness Score Trend

<LineChart
data={yearlyAvgTrend}
x=year
y=avg
xFmt=yyyy
yFmt=num3
yScale=true
yGridlines=false
yAxisLabels=false
markers=true
markerShape=emptyCircle
title="Happiness Score Over Time"
labels=true
sort=false>
<ReferenceArea xMin='2020' xMax='2022' label="Covid-19" color=red/>
</LineChart>

### Regional Composition of Happiness Score Categories

| Category  | score range |
| --------- | ----------- |
| Unhappy   | 0-3         |
| Neutral   | 3-5         |
| Satisfied | 5-7         |
| Happy     | 7-10        |

<BarChart
data={regionalcategorycount}
series=region
x=category
y=count
title="Regional Composition of Happiness Score Categories"
swapXY=true
labels=true
yGridlines=false
yAxisLabels=false
/>

### Select a factor to see its trend against happiness score:

<Grid cols=2>
<center>
<Dropdown name=factor>
<DropdownOption value="ebGDP" valueLabel="GDP per capita"/> 
<DropdownOption value="ebSocialSupport" valueLabel="Social Support"/> 
<DropdownOption value="ebLifeExpectancy" valueLabel="Life Expectancy"/> 
<DropdownOption value="ebFreedomOfLifeChoices" valueLabel="Freedom Of Life Choices"/> 
<DropdownOption value="ebGenerosity" valueLabel="Generosity"/> 
<DropdownOption value="ebCorruption" valueLabel="Corruption"/> 
</Dropdown>
</center>
<center>
<Dropdown name=factor2>
<DropdownOption value="ebSocialSupport" valueLabel="Social Support"/> 
<DropdownOption value="ebGDP" valueLabel="GDP per capita"/> 
<DropdownOption value="ebLifeExpectancy" valueLabel="Life Expectancy"/> 
<DropdownOption value="ebFreedomOfLifeChoices" valueLabel="Freedom Of Life Choices"/> 
<DropdownOption value="ebGenerosity" valueLabel="Generosity"/> 
<DropdownOption value="ebCorruption" valueLabel="Corruption"/> 
</Dropdown>
</center>
</Grid>

{#if inputs.factor.value != "" }
<Grid cols=2>
<ScatterPlot
data={hs2024}
y={inputs.factor.value}
x=score
xAxisTitle="Happiness Score"
yAxisTitle={inputs.factor.label}
/>

{#if inputs.factor2.value != "" }
<ScatterPlot
data={hs2024}
y={inputs.factor2.value}
x=score
xAxisTitle="Happiness Score"
yAxisTitle={inputs.factor2.label}
/>
{/if}

</Grid>
{/if}

### Select two factors to see their correlation:

<Grid cols=2>
<center>
<Dropdown name=factor3>
<DropdownOption value="" valueLabel="Select a factor"/>
<DropdownOption value="ebGDP" valueLabel="GDP per capita"/> 
<DropdownOption value="ebSocialSupport" valueLabel="Social Support"/> 
<DropdownOption value="ebLifeExpectancy" valueLabel="Life Expectancy"/> 
<DropdownOption value="ebFreedomOfLifeChoices" valueLabel="Freedom Of Life Choices"/> 
<DropdownOption value="ebGenerosity" valueLabel="Generosity"/> 
<DropdownOption value="ebCorruption" valueLabel="Corruption"/> 
</Dropdown>
</center>
<center>
<Dropdown name=factor4>
<DropdownOption value="" valueLabel="Select a factor"/>
<DropdownOption value="ebGDP" valueLabel="GDP per capita"/> 
<DropdownOption value="ebSocialSupport" valueLabel="Social Support"/> 
<DropdownOption value="ebLifeExpectancy" valueLabel="Life Expectancy"/> 
<DropdownOption value="ebFreedomOfLifeChoices" valueLabel="Freedom Of Life Choices"/> 
<DropdownOption value="ebGenerosity" valueLabel="Generosity"/> 
<DropdownOption value="ebCorruption" valueLabel="Corruption"/> 
</Dropdown>
</center>
</Grid>

{#if inputs.factor3.value != "" && inputs.factor4.value != ""}
<ScatterPlot
data={hs2024}
y={inputs.factor3.value}
x={inputs.factor4.value}
xAxisTitle={inputs.factor4.label}
yAxisTitle={inputs.factor3.label}
/>

{/if}
