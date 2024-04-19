```sql getCountries
select country, REPLACE(score, ',', '.') as score, REPLACE(ebGDP, ',', '.') as ebGDP, REPLACE(ebSocialSupport, ',','.') as ebSocialSupport, REPLACE(ebLifeExpectancy, ',','.') as ebLifeExpectancy, REPLACE(ebFreedomOfLifeChoices, ',','.') as ebFreedomOfLifeChoices, REPLACE(ebGenerosity, ',','.') as ebGenerosity, REPLACE(ebCorruption
, ',','.') as ebCorruption from happiness_score.HS_2022
```

```sql getHomeScore
select country, score, ebGDP as "GDP", ebSocialSupport as "Social Support", ebLifeExpectancy as "Life Expectancy", ebFreedomOfLifeChoices as "Freedom Of Life Choices", ebGenerosity as "Generosity", ebCorruption as "Corruption" from ${getCountries} where country = '${inputs.home.value}'
```

```sql getCountryScore
select country, score, ebGDP as "GDP", ebSocialSupport as "Social Support", ebLifeExpectancy as "Life Expectancy", ebFreedomOfLifeChoices as "Freedom Of Life Choices", ebGenerosity as "Generosity", ebCorruption as "Corruption" from ${getCountries} where country in ('${inputs.home.value}', '${inputs.away.value}')
```

```sql getAwayScore
select country, score, ebGDP as "GDP", ebSocialSupport as "Social Support", ebLifeExpectancy as "Life Expectancy", ebFreedomOfLifeChoices as "Freedom Of Life Choices", ebGenerosity as "Generosity", ebCorruption as "Corruption" from ${getCountries} where country = '${inputs.away.value}'
```

```sql getAll
select country, REPLACE(ebGDP, ',', '.') as ebGDP, REPLACE(ebSocialSupport, ',','.') as ebSocialSupport, REPLACE(ebLifeExpectancy, ',','.') as ebLifeExpectancy, REPLACE(ebFreedomOfLifeChoices, ',','.') as ebFreedomOfLifeChoices, REPLACE(ebGenerosity, ',','.') as ebGenerosity, REPLACE(ebCorruption
, ',','.') as ebCorruption from happiness_score.HS_2022
```

## Select two countries to compare their happiness scores

<center>
<Dropdown data={getCountries} name=home  title="Select a Country" value=country order=country defaultValue="Afghanistan">
<DropdownOption valueLabel="None" value="" />
</Dropdown>
<Dropdown data={getCountries} name=away  title="Select a Country" value=country order=country defaultValue="Algeria">
<DropdownOption valueLabel="None" value="" />
</Dropdown>
</center>

{#if inputs.home.value != "" && inputs.away.value != ""}

<center>
<BigValue
data={getHomeScore}
value=score
title={inputs.home.value + " Happiness Score"}
/>

<BigValue
data={getAwayScore}
value=score
title={inputs.away.value + " Happiness Score"}
/>

</center>

<BarChart data={getCountryScore} x=country y={["GDP", "Social Support", "Life Expectancy", "Freedom Of Life Choices", "Generosity", "Corruption"]} title="Happiness Score by Country" swapXY=true/>

{/if}
