/*5. Find the average number of strikeouts per game by decade since 1920. 
Round the numbers you report to 2 decimal places. 
Do the same for home runs per game. 
Do you see any trends?*/

--IS soa and SO same?
SELECT SO, SOA
FROM teams;
--NO

--as CTE, Average number of strikeouts per game by decade since 1920:
--SOA (strikeouts by pitcher)
WITH decades AS (SELECT DISTINCT yearid, G, SOA, AVG(SOA/G) OVER(PARTITION BY G) as avg_soa,
		CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920S'
			 WHEN yearid BETWEEN 1930 AND 1939 THEN '1930S'
			 WHEN yearid BETWEEN 1940 AND 1949 THEN '1940S'
			 WHEN yearid BETWEEN 1950 AND 1959 THEN '1950S'
			 WHEN yearid BETWEEN 1960 AND 1969 THEN '1960S'
			 WHEN yearid BETWEEN 1970 AND 1979 THEN '1970S'
			 WHEN yearid BETWEEN 1980 AND 1989 THEN '1980S'
			 WHEN yearid BETWEEN 1990 AND 1999 THEN '1990S'
			 WHEN yearid BETWEEN 2000 AND 2009 THEN '2000S'
			 WHEN yearid BETWEEN 2010 AND 2016 THEN '2010S' END AS decades
			FROM teams)
SELECT decades, ROUND(AVG(avg_soa), 2)
FROM decades
WHERE decades IS NOT NULL
GROUP BY decadeS
ORDER BY decades;

--SO (strikeouts by batter)
WITH decades AS (SELECT DISTINCT yearid, G, SO, AVG(SO/G) OVER(PARTITION BY G) as avg_so,
		CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920S'
			 WHEN yearid BETWEEN 1930 AND 1939 THEN '1930S'
			 WHEN yearid BETWEEN 1940 AND 1949 THEN '1940S'
			 WHEN yearid BETWEEN 1950 AND 1959 THEN '1950S'
			 WHEN yearid BETWEEN 1960 AND 1969 THEN '1960S'
			 WHEN yearid BETWEEN 1970 AND 1979 THEN '1970S'
			 WHEN yearid BETWEEN 1980 AND 1989 THEN '1980S'
			 WHEN yearid BETWEEN 1990 AND 1999 THEN '1990S'
			 WHEN yearid BETWEEN 2000 AND 2009 THEN '2000S'
			 WHEN yearid BETWEEN 2010 AND 2016 THEN '2010S' END AS decades
			FROM teams)
SELECT decades, ROUND(AVG(avg_so), 2) AS avg_soa
FROM decades
WHERE decades IS NOT NULL
GROUP BY decadeS
ORDER BY decades;


--Do the same for home runs per game. =HR

WITH decades AS (SELECT DISTINCT yearid, G, HR, AVG(HR/G) OVER(PARTITION BY G) as avg_hr,
		CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920S'
			 WHEN yearid BETWEEN 1930 AND 1939 THEN '1930S'
			 WHEN yearid BETWEEN 1940 AND 1949 THEN '1940S'
			 WHEN yearid BETWEEN 1950 AND 1959 THEN '1950S'
			 WHEN yearid BETWEEN 1960 AND 1969 THEN '1960S'
			 WHEN yearid BETWEEN 1970 AND 1979 THEN '1970S'
			 WHEN yearid BETWEEN 1980 AND 1989 THEN '1980S'
			 WHEN yearid BETWEEN 1990 AND 1999 THEN '1990S'
			 WHEN yearid BETWEEN 2000 AND 2009 THEN '2000S'
			 WHEN yearid BETWEEN 2010 AND 2016 THEN '2010S' END AS decades
			FROM teams)
SELECT decades, ROUND(AVG(avg_HR), 2) AS avg_hr
FROM decades
WHERE decades IS NOT NULL
GROUP BY decadeS
ORDER BY decades;


--Do you see any trends?

WITH decades1 AS (SELECT DISTINCT yearid, G, SOA, AVG(SOA/G) OVER(PARTITION BY G) as avg_soa,
		CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920S'
			 WHEN yearid BETWEEN 1930 AND 1939 THEN '1930S'
			 WHEN yearid BETWEEN 1940 AND 1949 THEN '1940S'
			 WHEN yearid BETWEEN 1950 AND 1959 THEN '1950S'
			 WHEN yearid BETWEEN 1960 AND 1969 THEN '1960S'
			 WHEN yearid BETWEEN 1970 AND 1979 THEN '1970S'
			 WHEN yearid BETWEEN 1980 AND 1989 THEN '1980S'
			 WHEN yearid BETWEEN 1990 AND 1999 THEN '1990S'
			 WHEN yearid BETWEEN 2000 AND 2009 THEN '2000S'
			 WHEN yearid BETWEEN 2010 AND 2016 THEN '2010S' END AS decades
			FROM teams),
		decades2 AS (SELECT DISTINCT yearid, G, SO, AVG(SO/G) OVER(PARTITION BY G) as avg_so,
		CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920S'
			 WHEN yearid BETWEEN 1930 AND 1939 THEN '1930S'
			 WHEN yearid BETWEEN 1940 AND 1949 THEN '1940S'
			 WHEN yearid BETWEEN 1950 AND 1959 THEN '1950S'
			 WHEN yearid BETWEEN 1960 AND 1969 THEN '1960S'
			 WHEN yearid BETWEEN 1970 AND 1979 THEN '1970S'
			 WHEN yearid BETWEEN 1980 AND 1989 THEN '1980S'
			 WHEN yearid BETWEEN 1990 AND 1999 THEN '1990S'
			 WHEN yearid BETWEEN 2000 AND 2009 THEN '2000S'
			 WHEN yearid BETWEEN 2010 AND 2016 THEN '2010S' END AS decades
			FROM teams),
		decades3 AS  (SELECT DISTINCT yearid, G, HR, AVG(HR/G) OVER(PARTITION BY G) as avg_hr,
		CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920S'
			 WHEN yearid BETWEEN 1930 AND 1939 THEN '1930S'
			 WHEN yearid BETWEEN 1940 AND 1949 THEN '1940S'
			 WHEN yearid BETWEEN 1950 AND 1959 THEN '1950S'
			 WHEN yearid BETWEEN 1960 AND 1969 THEN '1960S'
			 WHEN yearid BETWEEN 1970 AND 1979 THEN '1970S'
			 WHEN yearid BETWEEN 1980 AND 1989 THEN '1980S'
			 WHEN yearid BETWEEN 1990 AND 1999 THEN '1990S'
			 WHEN yearid BETWEEN 2000 AND 2009 THEN '2000S'
			 WHEN yearid BETWEEN 2010 AND 2016 THEN '2010S' END AS decades
			FROM teams)
SELECT decades1.decades, 
		ROUND(AVG(avg_soa), 2) AS avg_soa,
		ROUND(AVG(avg_so), 2) AS avg_so,
		ROUND(AVG(avg_HR), 2) AS avg_hr
FROM decades1
FULL JOIN decades2
ON decades1.decades=decades2.decades
FULL JOIN decades3
ON decades1.decades=decades3.decades
WHERE decades1.decades IS NOT NULL
GROUP BY decades1.decades
ORDER BY decades;

/*Trends: 
SOA increased over decades
SO increased over decades
HR increased over decades
1920's and 1930's had lowest values
