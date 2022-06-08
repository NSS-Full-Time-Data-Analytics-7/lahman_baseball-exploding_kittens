/* Using the attendance figures from the homegames table, 
find the teams and parks which had the top 5 average attendance per game in 2016
(where average attendance is defined as total attendance divided by number of games). 
Only consider parks where there were at least 10 games played. 
Report the park name, team name, and average attendance. 
Repeat for the lowest 5 average attendance. */

--top 5 attendance
SELECT park, team, attendance/games AS top_5_avg_attendance
FROM homegames
WHERE span_first BETWEEN '2016-01-01' AND '2016-12-31'
AND games >= 10
ORDER BY attendance DESC
LIMIT 5;
--Highest attendance = LAN 45,719

--bottom 5 attendance
SELECT park, team, attendance/games AS bottom_5_avg_attendance
FROM homegames
WHERE span_first BETWEEN '2016-01-01' AND '2016-12-31'
AND games >= 10
ORDER BY attendance 
LIMIT 5;
--Lowest attendance = TBA 15,878



