/*From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
What is the smallest number of wins for a team that did win the world series? 
Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. 
Then redo your query, excluding the problem year. 
How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
What percentage of the time?*/

--From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 

SELECT teamid, yearid, SUM(W) OVER(PARTITION BY teamid, yearid) AS wins_per_team
FROM teams
WHERE WSWin = 'N'
AND yearid BETWEEN 1970 AND 2016
ORDER BY wins_per_team DESC;

--SEATTLE : 116 :2001
--NOTE: no game in 1994

--What is the smallest number of wins for a team that did win the world series? 

SELECT teamid, yearid, SUM(W) OVER(PARTITION BY teamid, yearid) AS wins_per_team
FROM teams
WHERE WSWin = 'Y'
AND yearid BETWEEN 1970 AND 2016
ORDER BY wins_per_team;

--LAN : 63, 1981
--NOTE: no game in 1994

--Then redo your query, excluding the problem year. 

SELECT teamid, yearid, SUM(W) OVER(PARTITION BY teamid, yearid) AS wins_per_team
FROM teams
WHERE WSWin = 'Y'
AND yearid BETWEEN 1970 AND 2016
AND yearid <> 1981
ORDER BY wins_per_team;


--How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 

WITH all_stats AS (SELECT teamid, yearid, wswin, SUM(W) OVER(PARTITION BY teamid, yearid) AS wins_per_team,
				   MAX(W) OVER(PARTITION BY yearid) AS max_wins
					FROM teams
					WHERE yearid BETWEEN 1970 AND 2016
					AND yearid <> 1981
					ORDER BY yearid)
SELECT COUNT(*)
FROM all_stats
WHERE max_wins = wins_per_team
AND wswin = 'Y';
--12

WITH all_stats AS (SELECT teamid, yearid, wswin, SUM(W) OVER(PARTITION BY teamid, yearid) AS wins_per_team,
				   MAX(W) OVER(PARTITION BY yearid) AS max_wins
					FROM teams
					WHERE yearid BETWEEN 1970 AND 2016
					AND yearid <> 1981
					ORDER BY yearid)
SELECT COUNT(*) AS count_lose
FROM all_stats
WHERE max_wins = wins_per_team
AND wswin = 'N';
--39


/*How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
What percentage of the time?*/

WITH all_stats AS (SELECT teamid, yearid, wswin, SUM(W) OVER(PARTITION BY teamid, yearid) AS wins_per_team,
				   MAX(W) OVER(PARTITION BY yearid) AS max_wins
					FROM teams
					WHERE yearid BETWEEN 1970 AND 2016
					AND yearid <> 1981
					ORDER BY yearid)
SELECT COUNT(*) FILTER(WHERE wswin = 'Y'), COUNT(*) FILTER(WHERE wswin = 'N'), 
			(1.0*COUNT(*) FILTER(WHERE wswin='Y')/ COUNT(*)*1.0)*100 AS percent
FROM all_stats
	WHERE max_wins = wins_per_team

--23% of the time the team with the max number of game wins also wins the world series





