/* Bonus 11. Is there any correlation between number of wins and team salary? Use data from 2000 and later 
to answer this question. As you do this analysis, keep in mind that salaries across the 
whole league tend to increase together, so you may want to look on a year-by-year basis.*/

WITH salary_and_wins AS (WITH wins AS (SELECT t.w AS wins, t.teamid AS teams, t.yearid AS years
				FROM teams AS t
				WHERE t.yearid >= 2000),
	 salary AS (SELECT  SUM(s.salary::numeric) AS sum_salary, s.teamid AS teams, s.yearid AS years
				FROM salaries AS s
				WHERE s.yearid >= 2000
				GROUP BY s.teamid, s.yearid)
SELECT salary.years, salary.sum_salary, wins.wins, wins.teams, RANK () 
						 OVER(PARTITION BY years ORDER BY sum_salary) AS ranking
FROM wins 
JOIN salary 
USING (teams, years))

SELECT CORR("ranking", "wins") AS corr
FROM salary_and_wins



