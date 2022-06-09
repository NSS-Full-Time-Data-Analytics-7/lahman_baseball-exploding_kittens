/*10. Find all players who hit their career highest number of home runs in 2016. 
Consider only players who have played in the league for at least 10 years, and who hit at least one home run in 2016. 
Report the players' first and last names and the number of home runs they hit in 2016.*/
with higher_runs AS 
			(SELECT distinct yearid, people.namefirst, people.namelast, teamid, MAX(hr) as home_runs, debut AS start_playing
				FROM batting
				LEFT JOIN people
				ON batting.playerid = people.playerid
				WHERE yearid = 2016
				GROUP BY yearid, people.namefirst, people.namelast, teamid, start_playing
				ORDER BY home_runs DESC)

SELECT *
FROM higher_runs
WHERE start_playing <= '2006'
AND home_runs > 0
