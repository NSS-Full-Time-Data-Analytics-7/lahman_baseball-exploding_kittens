/*9. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? 
Give their full name and the teams that they were managing when they won the award.*/

--managers id code
SELECT playerid, awardid, yearid, lgid
FROM awardsmanagers
WHERE awardid = 'TSN Manager of the Year'
AND lgid <> 'ML'
GROUP BY playerid, awardid, yearid, lgid;

--player id ????
select distinct *
FROM awardsmanagers
LEFT JOIN managers
ON awardsmanagers.playerid = managers.playerid
where plyrmgr = 'Y'
order by plyrmgr;


--find name and team
SELECT distinct namefirst, namelast, managers.g as game_managed, name as team_name, managers.yearid
FROM people
INNER JOIN awardsmanagers
ON people.playerid = awardsmanagers.playerid
INNER JOIN managers
ON people.playerid = managers.playerid
INNER JOIN teams
ON managers.teamid = teams.teamid;



--all togheter
SELECT distinct namefirst, namelast, name as team_name, managers.yearid as year_managed,
	awardid as award_type, awardsmanagers.lgid as league_type, awardsmanagers.yearid as award_received
FROM people
INNER JOIN awardsmanagers
ON people.playerid = awardsmanagers.playerid
INNER JOIN managers
ON people.playerid = managers.playerid
INNER JOIN teams
ON managers.teamid = teams.teamid
WHERE awardid = 'TSN Manager of the Year'
AND awardsmanagers.lgid <> 'ML'
AND managers.yearid = awardsmanagers.yearid
GROUP BY namefirst, namelast, managers.g, name, managers.yearid, awardid, awardsmanagers.lgid, awardsmanagers.yearid
ORDER BY managers.yearid DESC;


