-- Open-ended questions
/*11. Is there any correlation between number of wins and team salary? 
Use data from 2000 and later to answer this question. 
As you do this analysis, keep in mind that salaries across the whole league tend to increase together, so you may want to look on a year-by-year basis.*/

SELECT teams.yearid, name AS team, SUM(salary::numeric::money) AS total_salary, w as total_wins
FROM salaries
INNER JOIN teams ON salaries.teamid = teams.teamid
WHERE teams.yearid >= 2000
GROUP BY teams.yearid, name, w
ORDER BY teams.yearid;


--need a number per year
SELECT teams.yearid, name AS team, SUM(salary::numeric::money) OVER(PARTITION BY teams.teamid, teams.yearid,) AS total_salary, w as total_wins
FROM salaries
INNER JOIN teams ON salaries.teamid = teams.teamid
WHERE teams.yearid >= 2000
GROUP BY teams.yearid, name, w, salaries.salary, teams.teamid
ORDER BY teams.yearid;


--needs to take out duplicates
WITH wins AS (SELECT t.w AS wins, t.teamid AS teams, t.yearid AS YEARS, name
				FROM teams AS t
				WHERE t.yearid >= 2000),
	 salary AS (SELECT  SUM(s.salary::numeric::money) AS sum_salary, s.teamid AS teams, s.yearid AS YEARS
				FROM salaries AS s
				WHERE s.yearid >= 2000
				GROUP BY s.teamid, s.yearid)
SELECT salary.YEARS, salary.sum_salary, wins.wins, name
FROM wins
FULL JOIN salary
USING (teams)
WHERE salary.years <=2003
ORDER BY name, years;

---different win table (wswin - temas)
WITH wins AS (SELECT t.wswin AS wins, t.teamid AS teams, t.yearid AS YEARS, t.teamid
				FROM teams AS t
				WHERE t.yearid >= 2000),
	 salary AS (SELECT  SUM(s.salary::numeric::money) AS sum_salary, s.teamid AS teams, s.yearid AS YEARS
				FROM salaries AS s
				WHERE s.yearid >= 2000
				GROUP BY s.teamid, s.yearid)
SELECT distinct salary.YEARS, salary.sum_salary, wins.wins, teamid
FROM wins
FULL JOIN salary
USING (teams)
WHERE salary.years <=2003
ORDER BY years, wins DESC;


---final
WITH final_table AS 
		(WITH wins AS (SELECT t.w AS wins, t.teamid AS teams, t.yearid AS YEAR
						FROM teams AS t
						WHERE t.yearid >= 2000),
			 salary AS (SELECT  SUM(s.salary::numeric::money) AS sum_salary, s.teamid AS teams, s.yearid AS YEAR
						FROM salaries AS s
						WHERE s.yearid >= 2000
						GROUP BY s.teamid, s.yearid)
		SELECT teams, wins, year, sum_salary, RANK() OVER(PARTITION BY year ORDER BY sum_salary) AS rank
		FROM wins
		FULL JOIN salary
		USING (teams, year))
SELECT CORR("wins", "rank")
FROM final_table
