---
queries:
  - everything: happiness/hs2024.sql
---

```sql getComparison
SELECT country,
       score,
       ebGDP                  AS "GDP",
       ebSocialSupport        AS "Social Support",
       ebLifeExpectancy       AS "Life Expectancy",
       ebFreedomOfLifeChoices AS "Freedom Of Life Choices",
       ebGenerosity           AS "Generosity",
FROM   ${everything}
WHERE  country IN ('${inputs.home.value}',
                   '${inputs.away.value}')
```

## Select two countries to compare their happiness scores

<center>
<Dropdown data={everything} name=home value=country order=country defaultValue="Afghanistan">
<DropdownOption valueLabel="Select A Country" value="" />
</Dropdown>
<Dropdown data={everything} name=away value=country order=country defaultValue="Algeria">
<DropdownOption valueLabel="Select A Country" value="" />
</Dropdown>
</center>

{#if inputs.home.value != "" && inputs.away.value != ""}

<center>

<BigValue
data={getComparison[0]}
value=score
title={inputs.home.value + " Happiness Score"}
/>

<BigValue
data={getComparison[1]}
value=score
title={inputs.away.value + " Happiness Score"}
/>

</center>

<BarChart
data={getComparison}
x=country
y={["GDP", "Social Support", "Life Expectancy", "Freedom Of Life Choices", "Generosity"]}
swapXY=true/>

{/if}
