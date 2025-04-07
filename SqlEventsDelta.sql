WITH ranked_event AS (
    SELECT event_type, value, time, ROW_NUMBER() OVER (PARTITION BY event_type ORDER BY time DESC) as row_num
    FROM events
)
SELECT e.event_type, e.value - e1.value as value
FROM ranked_event as e
INNER JOIN ranked_event AS e1 ON e1.event_type = e.event_type AND
e.row_num = 1 and e1.row_num = 2
ORDER BY e.event_type
