---
queries:
  - everything: happiness/hsArchive.sql
---

## Select two countries to compare their happiness scores

<center>
<Dropdown data={everything} name=country value=country order=country defaultValue="Afghanistan">
<DropdownOption valueLabel="Select A Country" value="" />
</Dropdown>
<Dropdown data={everything} name=year value=scoreYear order=scoreYear defaultValue=2021>
<DropdownOption valueLabel="Select Year" value="" />
</Dropdown>
</center>

{#if inputs.home.value != "" && inputs.away.value != ""}

# gg

{/if}
