WITH big_table AS (Select b.playerid, b.SB, (b.SB+ b.CS) AS attempts, p.namefirst, p.namelast
					FROM batting AS b
					INNER JOIN people AS p USING (playerid)
					WHERE b.SB IS NOT NULL
				   
					AND yearid=2016
					ORDER BY b.SB DESC)
SELECT ROUND(((1.0*sb)/(attempts*1.0))*100, 2) AS percent_successful, namefirst, namelast
FROM big_table
where attempts > 20
ORDER BY percent_successful DESC;

