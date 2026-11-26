SELECT AVG(home_score + away_score) AS avg_goals
FROM results
WHERE date BETWEEN '1900-01-01' AND '2000-12-31';


SELECT winner AS country, COUNT(*) AS shootout_winners
FROM shootouts
GROUP BY winner
ORDER BY winner ASC;


ALTER TABLE results ADD COLUMN match_id VARCHAR(255);
UPDATE results
SET match_id = CONCAT(date, '-', home_team, '-', away_team);


SELECT
    r.date,
    r.home_team,
    r.away_team,
    r.home_score,
    r.away_score,
    g.scorer,
    g.minute,
    so.winner AS shootout_winner
FROM results r
LEFT JOIN goalscorers g
    ON r.date = g.date
    AND r.home_team = g.home_team
    AND r.away_team = g.away_team
LEFT JOIN shootouts so
    ON r.date = so.date
    AND r.home_team = so.home_team
    AND r.away_team = so.away_team;


SELECT DISTINCT so.winner
FROM shootouts so
JOIN results r
    ON so.date = r.date
    AND so.home_team = r.home_team
    AND so.away_team = r.away_team
WHERE r.home_score = 1
  AND r.away_score = 1
ORDER BY so.winner;
