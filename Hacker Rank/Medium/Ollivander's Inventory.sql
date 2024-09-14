SELECT t1.id, t2.age, t1.coins_needed, t1.power
FROM wands t1
INNER JOIN wands_property t2 ON t1.code = t2.code
WHERE t2.is_evil = 0
AND (t2.age, t1.coins_needed, t1.power) IN (
    SELECT t2.age, MIN(t1.coins_needed), t1.power
    FROM wands t1
    INNER JOIN wands_property t2 ON t1.code = t2.code
    WHERE t2.is_evil = 0
    GROUP BY t2.age, t1.power
)
ORDER BY t1.power DESC, t2.age DESC;
