/*6. Find the player who had the most success stealing bases in 2016, where __success__ is measured as the percentage of stolen base attempts which are successful. 
(A stolen base attempt results either in a stolen base or being caught stealing.)
Consider only players who attempted _at least_ 20 stolen bases.*/

--tables to consider with stolen bases as SB and CS 
--fieldingPost table (opponent stolen bases) 
--people for the names

WITH big_table AS (Select b.playerid, b.SB, (b.SB+ b.CS) AS attempts, p.namefirst, p.namelast
					FROM batting AS b
					INNER JOIN people AS p USING (playerid)
					WHERE b.SB IS NOT NULL
				   
					AND yearid=2016
					ORDER BY b.SB DESC)
SELECT ROUND(((1.0*sb)/(attempts*1.0))*100, 2) AS percent_successful, namefirst, namelast
FROM big_table
where attempts > 20
ORDER BY percent_successful DESC
