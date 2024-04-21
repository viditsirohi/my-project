# World Happiness Report 2024

## Variable Definitions

---

- Happiness score or subjective well-being: The survey measure of SWB is from the February 15, 2024 release of the Gallup World Poll (GWP) covering years from 2005/06 to 2023. Unless stated otherwise, it is the national average response to the question of life evaluations. The English wording of the question is: "Please imagine a ladder, with steps numbered from 0 at the bottom to 10 at the top. The top of the ladder represents the best possible life for you and the bottom of the ladder represents the worst possible life for you. On which step of the ladder would you say you personally feel you stand at this time?" This measure is also referred to as Cantril life ladder, or just life ladder in our analysis.

- The statistics of GDP per capita: In purchasing power parity (PPP) at constant 2017 international dollar prices are from World Development Indicators (WDI, version 23, Metadata last updated on - Sep 27, 2023). The GDP figures for Taiwan, Syria, Palestinian Territories, Venezuela, Djibouti, and Yemen are from the Penn World Table 10.01. GDP per capita in 2023 are not yet available as of October 2023. We extend the GDP-per-capita time series from 2022 to 2023 using country-specific forecasts of real GDP growth in 2023 first from the Economic Outlook No 113 (June 2023) and then, if missing, forecasts from World Bank's Global Economic Prospects (Last Updated: 06/06/2023). The GDP growth forecasts are adjusted for population growth with the subtraction of 2021-22 population growth as the projected 2022-23 growth. A few countries/territories have their GDP figures from the Penn World Table that ends in 2019. We derive their 2021-2023 GDP values based on the 2019 values and the projected growth rates if they are available.

- Healthy Life Expectancy: Healthy life expectancies at birth are based on the data extracted from the World Health Organization's (WHO) Global Health Observatory data repository (Last updated: 2020-12-04). The data at the source are available for the years 2000, 2010, 2015, and 2019. To match this report's sample period, interpolation and extrapolation are used.

- Social support: The national average of the binary responses to the GWP question: "If you were in trouble, do you have relatives or friends you can count on to help you whenever you need them, or not?"

- Freedom to make life choices: The national average of responses to the GWP question: "Are you satisfied or dissatisfied with your freedom to choose what you do with your life?"

- Generosity: The residual of regressing national average of response to the GWP question "Have you donated money to a charity in the past month?" on GDP per capita.

- Corruption Perception: The measure is the national average of the survey responses to two questions in the GWP: "Is corruption widespread throughout the government or not" and "Is corruption widespread within businesses or not?" The overall perception is just the average of the two 0-or-1 responses. In case the perception of government corruption is missing, we use the perception of business corruption as the overall perception. The corruption perception at the national level is just the average response of the overall perception at the individual level.

- Positive affect: Defined as the average of three positive affect measures in GWP: laugh, enjoyment, and doing interesting things in the Gallup World Poll. These measures are the responses to the following three questions, respectively: "Did you smile or laugh a lot yesterday?", and "Did you experience the following feelings during A LOT OF THE DAY yesterday? How about Enjoyment?", "Did you learn or do something interesting yesterday?"

- Negative affect: Defined as the average of three negative affect measures in GWP. They are worry, sadness, and anger, respectively the responses to "Did you experience the following feelings during A LOT OF THE DAY yesterday? How about Worry?", "Did you experience the following feelings during A LOT OF THE DAY yesterday? How about Sadness?", and "Did you experience the following feelings during A LOT OF THE DAY yesterday? How about Anger?"

- Institutional trust: The first principal component of the following five measures: confidence in the national government, confidence in the judicial system and courts, confidence in the honesty of elections, confidence in the local police force, and perceived corruption in business. This principal component is then used to create a binary measure of high institutional trust using the 75th percentile in the global distribution
