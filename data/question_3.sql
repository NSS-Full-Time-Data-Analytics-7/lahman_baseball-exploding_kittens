/* 3. Find all players in the database who played at Vanderbilt University. 
Create a list showing each player’s first and last names as well as the total salary 
they earned in the major leagues.
Sort this list in descending order by the total salary earned. 
Which Vanderbilt player earned the most money in the majors?*/

SELECT DISTINCT people.namefirst, people.namelast, salary, schoolid
FROM salaries INNER JOIN collegeplaying 
ON salaries.playerid = collegeplaying.playerid
LEFT JOIN people ON collegeplaying.playerid = people.playerid
WHERE schoolid = 'vandy'
ORDER BY salary desc;
--David Price, 30,000,000
--70 total former Vandy players have earned a MLB salary





