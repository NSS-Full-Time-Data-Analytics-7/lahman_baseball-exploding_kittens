/*
In this question, you will explore the connection between number of wins and attendance.

Does there appear to be any correlation between attendance at home games and number of wins?
Do teams that win the world series see a boost in attendance the following year? 
What about teams that made the playoffs? Making the playoffs means either being a division winner or a wild card winner.*/
WITH wa AS (SELECT SUM(t.w) AS sum_wins, t.attendance
				FROM teams AS t
				WHERE attendance IS NOT NULL
				GROUP BY t.attendance, T.W)
SELECT CORR("sum_wins", "attendance") AS correlation
FROM wa;

SELECT w, attendance
FROM teams
--UNFINISHED
