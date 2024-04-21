SELECT
    region,
    case
        when score > 7 then 'Happy'
        when score > 5 then 'Satisfied'
        when score > 3 then 'Neutral'
        else 'Unhappy'
    end as category,
    CASE
        WHEN category = 'Unhappy' THEN '1'
        WHEN category = 'Neutral' THEN '2'
        WHEN category = 'Satisfied' THEN '3'
        WHEN category = 'Happy' THEN '4'
    END as category_order,
FROM
    happiness_score.hs2024
ORDER BY
    category_order DESC