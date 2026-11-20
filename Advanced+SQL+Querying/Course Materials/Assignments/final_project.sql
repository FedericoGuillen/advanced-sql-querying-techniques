-- PART I: SCHOOL ANALYSIS
-- 1. View the schools and school details tables
SELECT * FROM schools;
SELECT * FROM school_details;

-- 2. In each decade, how many schools were there that produced players?
SELECT 	 FLOOR(yearid / 10) * 10 AS decade, COUNT(DISTINCT schoolid) AS num_schools
FROM	 schools
GROUP BY decade
ORDER BY decade;

-- 3. What are the names of the top 5 schools that produced the most players?
SELECT	 sd.name_full, COUNT(DISTINCT s.playerid) AS num_players
FROM	 schools s LEFT JOIN school_details sd
		 ON s.schoolid = sd.schoolid
GROUP BY sd.name_full
ORDER BY num_players DESC
LIMIT	 5;


-- 4. For each decade, what were the names of the top 3 schools that produced the most players?
WITH ds AS	(SELECT	  FLOOR(s.yearid / 10) * 10 AS decade, sd.name_full, COUNT(DISTINCT s.playerid) AS num_players
			 FROM	  schools s LEFT JOIN school_details sd
					  ON s.schoolid = sd.schoolid
			 GROUP BY decade, sd.name_full),

	 rn AS	(SELECT	decade, name_full, num_players,
					ROW_NUMBER() OVER(PARTITION BY decade ORDER BY num_players DESC) AS row_num
			 FROM	ds)

SELECT	 decade, name_full, num_players
FROM	 rn
WHERE	 row_num <= 3
ORDER BY decade DESC, row_num;



-- PART II: SALARY ANALYSIS
-- 1. View the salaries table
SELECT DISTINCT(teamid) 
FROM salaries;

-- 2. Return the top 20% of teams in terms of average annual spending
WITH ts AS	(SELECT	 teamid, yearid, SUM(salary) AS total_spend
			 FROM	 salaries
			 GROUP BY teamid, yearid),

     sp AS	(SELECT   teamid, AVG(total_spend) AS avg_spend,
					 NTILE(5) OVER(ORDER BY AVG(total_spend) DESC) AS spend_pct
			 FROM	 ts
			 GROUP BY teamid)

SELECT	teamid, ROUND(avg_spend / 1000000, 1) AS avg_spend_millions
FROM	sp
WHERE	spend_pct = 1; 

-- 3. For each team, show the cumulative sum of spending over the years
WITH ts AS	(SELECT	 teamid, yearid, SUM(salary) AS total_spend
			 FROM	 salaries
			 GROUP BY teamid, yearid)

SELECT	 teamid, yearid, total_spend,
		 ROUND(SUM(total_spend) OVER(PARTITION BY teamid ORDER BY yearid) / 1000000, 1) AS cumulative_sum_millions
FROM 	 ts
ORDER BY teamid ASC, yearid ASC;

-- 4. Return the first year that each team's cumulative spending surpassed 1 billion
WITH ts AS	(SELECT	 teamid, yearid, SUM(salary) AS total_spend
			 FROM	 salaries
			 GROUP BY teamid, yearid),

	tscm AS (SELECT	 teamid, yearid, total_spend,
					 ROUND(SUM(total_spend) OVER(PARTITION BY teamid ORDER BY yearid) / 1000000, 1) AS cumulative_sum_millions
			 FROM 	 ts),

      fy AS	(SELECT	teamid, yearid, total_spend, cumulative_sum_millions,
					ROW_NUMBER() OVER (PARTITION BY teamid ORDER BY cumulative_sum_millions ASC) AS row_num
			 FROM	tscm
			 WHERE 	cumulative_sum_millions > 1000)

SELECT *
FROM fy
WHERE row_num = 1;

-- PART III: PLAYER CAREER ANALYSIS
-- 1. View the players table and find the number of players in the table
SELECT * FROM players;

SELECT COUNT(DISTINCT playerid)
FROM players;

-- 2. For each player, calculate their age at their first game, their last game, and their career length (all in years). 
--Sort from longest career to shortest career.
SELECT	 namegiven, 
		 EXTRACT(YEAR FROM AGE(debut,
			         MAKE_DATE(birthyear, birthmonth, birthday)
			    	 )) AS starting_age,
		 EXTRACT(YEAR FROM AGE(finalgame,
			         MAKE_DATE(birthyear, birthmonth, birthday)
			    	 )) AS end_age,
	 	 EXTRACT(YEAR FROM AGE(finalgame, debut)) AS career_length
FROM	 players
WHERE	 EXTRACT(YEAR FROM AGE(finalgame, debut)) IS NOT NULL
ORDER BY career_length DESC;

-- 3. What team did each player play on for their starting and ending years?
SELECT 	 p.namegiven,
		 s.yearid AS starting_year, s.teamid AS starting_team, 
		 e.yearid AS ending_year, e.teamid AS ending_team
FROM	 players p INNER JOIN salaries s
							 ON p.playerid = s.playerid
							 AND EXTRACT(YEAR FROM p.debut) = s.yearid
				   INNER JOIN salaries e
							 ON p.playerid = e.playerid
							 AND EXTRACT(YEAR FROM p.finalgame) = e.yearid

-- 4. How many players started and ended on the same team and also played for over a decade?
SELECT 	 p.namegiven,
		 s.yearid AS starting_year, s.teamid AS starting_team, 
		 e.yearid AS ending_year, e.teamid AS ending_team
FROM	 players p INNER JOIN salaries s
							 ON p.playerid = s.playerid
							 AND EXTRACT(YEAR FROM p.debut) = s.yearid
				   INNER JOIN salaries e
							 ON p.playerid = e.playerid
							 AND EXTRACT(YEAR FROM p.finalgame) = e.yearid
WHERE	 s.teamid = e.teamid AND e.yearid - s.yearid > 10;

-- PART IV: PLAYER COMPARISON ANALYSIS
-- 1. View the players table
SELECT * FROM players;

-- 2. Which players have the same birthday?
WITH bn AS (SELECT	 MAKE_DATE(birthyear, birthmonth, birthday) AS birthdate,
					 namegiven
			FROM	 players)

SELECT   birthdate,
		 STRING_AGG(namegiven, ', ') AS players
FROM	 bn
WHERE	 EXTRACT(YEAR FROM birthdate) BETWEEN 1980 AND 1990
GROUP BY birthdate
ORDER BY birthdate

-- 3. Create a summary table that shows for each team, what percent of players bat right, left and both
SELECT	s.teamID,
		ROUND(SUM(CASE WHEN p.bats = 'R' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_right,
        ROUND(SUM(CASE WHEN p.bats = 'L' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_left,
        ROUND(SUM(CASE WHEN p.bats = 'B' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_both
FROM	salaries s LEFT JOIN players p
		ON s.playerID = p.playerID
GROUP BY s.teamID;


-- This is the more accurate solution, which first removes duplicate playerID-teamID combos from the salaries table before pivoting
-- The duplicates exist because each row in the salaries table represents a player's salary on a particular team for a particular year
WITH up AS (SELECT DISTINCT s.teamID, s.playerID, p.bats
           FROM salaries s LEFT JOIN players p
           ON s.playerID = p.playerID) -- unique players CTE

SELECT teamID,
		ROUND(100.0 * SUM(CASE WHEN bats = 'R' THEN 1 ELSE 0 END) / COUNT(playerID), 2) AS bats_right,
    	ROUND(100.0 * SUM(CASE WHEN bats = 'L' THEN 1 ELSE 0 END) / COUNT(playerID), 2) AS bats_left,
    	ROUND(100.0 * SUM(CASE WHEN bats = 'B' THEN 1 ELSE 0 END) / COUNT(playerID), 2) AS bats_both
FROM up
GROUP BY teamid
ORDER BY teamid ASC;

-- 4. How have average height and weight at debut game changed over the years, and what's the decade-over-decade difference?
WITH hw AS (SELECT	FLOOR(EXTRACT(YEAR FROM debut) / 10) * 10 AS decade,
					AVG(height) AS avg_height, AVG(weight) AS avg_weight
			FROM	players
			GROUP BY decade)
            
SELECT	decade,
		avg_height - LAG(avg_height) OVER(ORDER BY decade) AS height_diff,
        avg_weight - LAG(avg_weight) OVER(ORDER BY decade) AS weight_diff
FROM	hw
WHERE	decade IS NOT NULL;

