/*Is there any correlation between number of wins and team salary? 
Use data from 2000 and later to answer this question. As you do this analysis, 
keep in mind that salaries across the whole league tend to increase together, 
so you may want to look on a year-by-year basis*/

SELECT *
FROM teams
WHERE yearid = 2000;

SELECT * 
FROM salaries;




SELECT DISTINCT s.teamid, s.yearid, 
			SUM(s.salary) OVER(PARTITION BY s.teamid, s.yearid) AS sum_salary, 
			t.w 
FROM salaries AS s
INNER JOIN teams AS t
USING (teamid)
WHERE s.yearid >= 2000
GROUP BY s.teamid, s.yearid, s.salary, t.w
ORDER BY s.yearid;

--salary_per_team_per_year 
SELECT  SUM(s.salary::numeric), s.teamid, s.yearid
FROM salaries AS s
WHERE s.yearid >= 2000
GROUP BY 2,3
ORDER BY s.yearid;
--wins per team per year
SELECT t.w, t.teamid, t.yearid
FROM teams AS t
WHERE t.yearid >= 2000;

--join the above 2

WITH wins AS (SELECT t.w AS wins, t.teamid AS teams, t.yearid AS year
				FROM teams AS t
				WHERE t.yearid >= 2000
				ORDER BY year),
	 salary AS (SELECT  SUM(s.salary::numeric) AS sum_salary, s.teamid AS teams, s.yearid AS year
				FROM salaries AS s
				WHERE s.yearid >= 2000
				GROUP BY s.yearid, s.teamid
			   ORDER BY year)
SELECT  teams, wins, year, sum_salary, RANK() OVER(PARTITION BY year ORDER BY sum_salary),
	RANK() OVER(PARTITION BY year ORDER BY wins) AS RANK_WIN
FROM wins 
FULL JOIN salary
USING (teams, year);

--big cte
WITH salary_and_wins AS
		(WITH wins AS (SELECT t.w AS wins, t.teamid AS teams, t.yearid AS year
						FROM teams AS t
						WHERE t.yearid >= 2000
						ORDER BY year),
			 salary AS (SELECT  SUM(s.salary::numeric) AS sum_salary, s.teamid AS teams, s.yearid AS year
						FROM salaries AS s
						WHERE s.yearid >= 2000
						GROUP BY s.yearid, s.teamid
					   ORDER BY year)
		SELECT  teams, wins, year, sum_salary, 
		 	RANK() OVER(PARTITION BY year ORDER BY sum_salary) AS rank_salary, 
		 	RANK() OVER(PARTITION BY year ORDER BY wins) AS rank_win
		FROM wins 
		FULL JOIN salary
		USING (teams, year))
SELECT corr("rank_win", "rank_salary") AS correlation
FROM salary_and_wins;

--positive correlation (weak?)


