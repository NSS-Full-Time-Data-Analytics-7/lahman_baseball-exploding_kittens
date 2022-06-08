/* Find the name and height of the shortest player in the database. 
How many games did he play in? What is the name of the team for which he played?*/
SELECT namefirst, namelast, namegiven, playerid, MIN(height) AS min_height
FROM people
GROUP BY namefirst, namelast, namegiven, playerid
ORDER BY min_height;
-- Eddie Gaedel (Edward Carl) 43 inches (3.5 feet)?
-- playerid: "gaedeed01"


SELECT distinct batting.playerid, batting.yearid, stint as num_games, teams.teamid, teams.name as team_name, batting.bb
FROM batting
INNER JOIN teams
ON batting.teamid = teams.teamid
WHERE batting.playerid = 'gaedeed01';
--he played 1 game in 1951 as a bb (base on balls)
--he had dor


