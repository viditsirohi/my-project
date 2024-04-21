SELECT region, 
case 
    when score > 7 then 'Very Happy'
    when score > 5 then 'Happy'
    when score > 3 then 'Neutral'
    else 'Unhappy'
end as category
FROM happiness