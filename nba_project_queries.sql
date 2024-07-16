-- All of the statistics and information in this project are referenced from wwww.basketball-reference.com
-- Creating the NBA project database of my favourite players for the 2022-23 NBA regular season and playoffs
CREATE DATABASE nba_project;

-- Creating the team information table
CREATE TABLE team (
			 team_id CHAR(3) PRIMARY KEY,
             team_name VARCHAR(250),
             city VARCHAR(250),
             state_province VARCHAR(250),
             country VARCHAR(250));

-- Inserting the values of the NBA teams into the team information table
INSERT INTO team (team_id, team_name, city, state_province, country)
VALUES ('ATL', 'Atlanta Hawks', 'Atlanta', 'Georgia', 'United States'),
	   ('BOS', 'Boston Celtics', 'Boston', 'Massachusetts', 'United States'),
       ('BRK', 'Brooklyn Nets', 'New York City', 'New York', 'United States'),
       ('CHI', 'Chicago Bulls', 'Chicago', 'Illinois', 'United States'),
       ('CHO', 'Charlotte Hornets', 'Charlotte', 'North Carolina', 'United States'),
       ('CLE', 'Cleveland Cavaliers', 'Cleveland', 'Ohio', 'United States'),
       ('DAL', 'Dallas Mavericks', 'Dallas', 'Texas', 'United States'),
       ('DEN', 'Denver Nuggets', 'Denver', 'Colorado', 'United States'),
       ('DET', 'Detroit Pistons', 'Detroit', 'Michigan', 'United States'),
       ('GSW', 'Golden State Warriors', 'San Francisco', 'California', 'United States'),
       ('HOU', 'Houston Rockets', 'Houston', 'Texas', 'United States'),
       ('IND', 'Indiana Pacers', 'Indianapolis', 'Indiana', 'United States'),
       ('LAC', 'Los Angeles Clippers', 'Los Angeles', 'California', 'United States'),
       ('LAL', 'Los Angeles Lakers', 'Los Angeles', 'California', 'United States'),
       ('MEM', 'Memphis Grizzlies', 'Memphis', 'Tennessee', 'United States'),
       ('MIA', 'Miami Heat', 'Miami', 'Florida', 'United States'),
       ('MIL', 'Milwaukee Bucks', 'Milwaukee', 'Wisconsin', 'United States'),
       ('MIN', 'Minnesota Timberwolves', 'Minneapolis', 'Minnesota', 'United States'),
       ('NOP', 'New Orleans Pelicans', 'New Orleans', 'Louisiana', 'United States'),
       ('NYK', 'New York Knicks', 'New York City', 'New York', 'United States'),
       ('OKC', 'Oklahoma City Thunder', 'Oklahoma City', 'Oklahoma', 'United States'),
       ('ORL', 'Orlando Magic', 'Orlando', 'Florida', 'United States'),
       ('PHI', 'Philadelphia 76ers', 'Philadelphia', 'Pennsylvania', 'United States'),
       ('PHO', 'Phoenix Suns', 'Phoenix', 'Arizona', 'United States'),
       ('POR', 'Portland Trail Blazers', 'Portland', 'Oregon', 'United States'),
       ('SAC', 'Sacramento Kings', 'Sacramento', 'California', 'United States'),
       ('SAS', 'San Antonio Spurs', 'San Antonio', 'Texas', 'United States'),
       ('TOR', 'Toronto Raptors', 'Toronto', 'Ontario', 'Canada'),
       ('UTA', 'Utah Jazz', 'Salt Lake City', 'Utah', 'United States'),
       ('WAS', 'Washington Wizards', 'Washington', 'D.C.', 'United States');

-- Creating the player information table
CREATE TABLE player_information (
			 player_id INT PRIMARY KEY AUTO_INCREMENT,
             first_name VARCHAR(250),
             last_name VARCHAR(250),
             birth_date DATE,
             country VARCHAR(250),
             draft_year VARCHAR(250),
             current_team_id CHAR(3),
             FOREIGN KEY (current_team_id) REFERENCES team(team_id));

-- Inserting the values of my favourite NBA players into the player information table
INSERT INTO player_information (first_name, last_name, birth_date, country, draft_year, current_team_id)
VALUES ('Kevin', 'Durant', '1988-09-29', 'United States', '2007', 'PHO'),
	   ('Kyrie', 'Irving', '1992-03-23', 'United States', '2011', 'DAL'),
       ('Devin', 'Booker', '1996-10-30', 'United States', '2015', 'PHO');

-- Creating the player game logs table for the 2022-2023 NBA season
-- All of the data in the table are scraped on and imported from Excel
CREATE TABLE player_game_logs (
			 game_id INT PRIMARY KEY AUTO_INCREMENT,
             game_type VARCHAR(250),
			 game_date DATE,
             player_id INT,
             active_inactive VARCHAR(250),
             team_id CHAR(3),
             opp_team_id CHAR(3),
             home_away VARCHAR(250),
			 win_loss CHAR(1),
             minutes_played REAL,
             field_goals_made REAL,
             field_goals_attempted REAL,
             field_goals_percentage REAL,
             three_pointers_made REAL,
             three_pointers_attempted REAL,
             three_pointers_percentage REAL,
             free_throws_made REAL,
             free_throws_attempted REAL,
             free_throws_percentage REAL,
             offensive_rebounds REAL,
             defensive_rebounds REAL,
             assists REAL,
             steals REAL,
             blocks REAL,
             turnovers REAL,
             fouls REAL,
             points REAL,
             plus_minus REAL,
             FOREIGN KEY (player_id) REFERENCES player_information(player_id),
             FOREIGN KEY (team_id) REFERENCES team(team_id),
             FOREIGN KEY (opp_team_id) REFERENCES team(team_id));

-- Calculating the regular season and playoffs averages per game for each player
SELECT CONCAT(first_name, ' ', last_name) AS Full_Name,
       Game_Type,
       Team_Name,
       COUNT(*) AS Games_Played,
       ROUND(AVG(minutes_played), 1) AS MPG,
	   ROUND(AVG(field_goals_made), 1) AS FGM,
       ROUND(AVG(field_goals_attempted), 1) AS FGA,
       CONCAT(ROUND(((SUM(field_goals_made) / SUM(field_goals_attempted))*100), 1), '%') AS FG_PCT,
       ROUND(AVG(field_goals_made - three_pointers_made), 1) AS 2PM,
       ROUND(AVG(field_goals_attempted - three_pointers_attempted), 1) AS 2PA,
       CONCAT(ROUND(((SUM(field_goals_made) - SUM(three_pointers_made)) / (SUM(field_goals_attempted) - SUM(three_pointers_attempted)))*100, 1), '%') AS 2P_PCT,
       ROUND(AVG(three_pointers_made), 1) AS 3PM,
       ROUND(AVG(three_pointers_attempted), 1) AS 3PA,
       CONCAT(ROUND(((SUM(three_pointers_made) / SUM(three_pointers_attempted))*100), 1), '%') AS 3P_PCT,
       ROUND(AVG(free_throws_made), 1) AS FTM,
       ROUND(AVG(free_throws_attempted), 1) AS FTA,
       CONCAT(ROUND(((SUM(free_throws_made) / SUM(free_throws_attempted))*100), 1), '%') AS FT_PCT,
       ROUND(AVG(offensive_rebounds + defensive_rebounds), 1) AS RPG,
       ROUND(AVG(assists), 1) AS APG,
       ROUND(AVG(steals), 1) AS SPG,
       ROUND(AVG(blocks), 1) AS BPG,
       ROUND(AVG(turnovers), 1) AS TOV,
       ROUND(AVG(fouls), 1) AS FLS,
       ROUND(AVG(points), 1) AS PPG
FROM player_game_logs
JOIN player_information ON player_information.player_id = player_game_logs.player_id
JOIN team ON team.team_id = player_game_logs.team_id
WHERE active_inactive = 'Active'
GROUP BY player_game_logs.player_id, game_type, team_name
ORDER BY player_game_logs.player_id, game_type DESC, games_played DESC;

-- Calculating the regular season and playoffs totals for each player
SELECT CONCAT(first_name, ' ', last_name) AS Full_Name,
       Game_Type,
       Team_Name,
       COUNT(*) AS Games_Played,
       ROUND(SUM(minutes_played)) AS MP,
	   SUM(field_goals_made) AS FGM,
       SUM(field_goals_attempted) AS FGA,
       SUM(field_goals_made) - SUM(three_pointers_made) AS 2PM,
       SUM(field_goals_attempted) - SUM(three_pointers_attempted) AS 2PA,
       SUM(three_pointers_made) AS 3PM,
       SUM(three_pointers_attempted) AS 3PA,
       SUM(free_throws_made) AS FTM,
       SUM(free_throws_attempted) AS FTA,
       SUM(offensive_rebounds + defensive_rebounds) AS REB,
       SUM(assists) AS AST,
       SUM(steals) AS STL,
       SUM(blocks) AS BLK,
       SUM(turnovers) AS TOV,
       SUM(fouls) AS FLS,
       SUM(points) AS PTS
FROM player_game_logs
JOIN player_information ON player_information.player_id = player_game_logs.player_id
JOIN team ON team.team_id = player_game_logs.team_id
WHERE active_inactive = 'Active'
GROUP BY player_game_logs.player_id, game_type, team_name
ORDER BY player_game_logs.player_id, game_type DESC, games_played DESC;

-- Calculating the total points, assists and rebounds for each player over the course of the regular season, including the difference in stats each game
SELECT Player_ID,
	   Team_ID,
       Game_Date,
       Points_Each_Game,
       points_each_game - LAG(points_each_game) OVER(PARTITION BY player_id ORDER BY game_date) AS Points_Diff_Each_Game,
       Total_Points_Season,
       Assists_Each_Game,
       assists_each_game - LAG(assists_each_game) OVER(PARTITION BY player_id ORDER BY game_date) AS Assists_Diff_Each_Game,
       Total_Assists_Season,
       Rebounds_Each_Game,
       rebounds_each_game - LAG(rebounds_each_game) OVER(PARTITION BY player_id ORDER BY game_date) AS Rebounds_Diff_Each_Game,
       Total_Rebounds_Season
FROM
(SELECT player_id,
	    team_id,
	    game_date,
        points AS points_each_game,
        SUM(points) OVER(PARTITION BY player_id ORDER BY game_date) AS total_points_season,
        assists AS assists_each_game,
        SUM(assists) OVER(PARTITION BY player_id ORDER BY game_date) AS total_assists_season,
        (offensive_rebounds + defensive_rebounds) AS rebounds_each_game,
        SUM(offensive_rebounds + defensive_rebounds) OVER(PARTITION BY player_id ORDER BY game_date) AS total_rebounds_season
		FROM player_game_logs
		WHERE active_inactive = 'Active' AND game_type = 'Regular Season') sub
ORDER BY player_id;

-- Calculating the points per game by each player during the months of the regular season, and the difference in points per game each month over the course of the regular season
WITH monthly_stats AS (
	SELECT player_id,
		  (CASE WHEN MONTH(game_date) = '1' THEN 'January'
                WHEN MONTH(game_date) = '2' THEN 'February'
                WHEN MONTH(game_date) = '3' THEN 'March'
                WHEN MONTH(game_date) = '4' THEN 'April'
                WHEN MONTH(game_date) = '5' THEN 'May'
                WHEN MONTH(game_date) = '6' THEN 'June'
                WHEN MONTH(game_date) = '7' THEN 'July'
                WHEN MONTH(game_date) = '8' THEN 'August'
                WHEN MONTH(game_date) = '9' THEN 'September'
                WHEN MONTH(game_date) = '10' THEN 'October'
                WHEN MONTH(game_date) = '11' THEN 'November'
                ELSE 'December'END) AS months,
		   YEAR(game_date) AS years,
           COUNT(*) AS games_played,
		   ROUND(AVG(points), 1) AS ppg
	FROM player_game_logs
	WHERE active_inactive = 'Active' AND game_type = 'Regular Season'
	GROUP BY 1, 2, 3
	ORDER BY 1, 3) 
SELECT Player_ID,
	   Months,
       Years, 
       Games_Played,
       PPG, 
       ROUND((ppg - LAG(ppg) OVER(PARTITION BY player_id ORDER BY years)), 1) AS PPG_Diff_Each_Month
FROM monthly_stats;

-- Calculating the average stats and shooting splits for each player, before and after the 2023 NBA All-Star Break, during the regular season
WITH pre_post_all_star AS (
	SELECT pgl.player_id,
		   first_name,
           last_name,
           team_id,
           'Pre-All Star Break' AS pre_or_post_allstar,
           COUNT(*) AS games_played,
           ROUND(AVG(points), 1) AS ppg,
           ROUND(AVG(assists), 1) AS apg,
           ROUND(AVG(offensive_rebounds+defensive_rebounds), 1) AS rpg,
           CONCAT(ROUND(((SUM(field_goals_made) / SUM(field_goals_attempted))*100), 1), '%') AS fg_pct,
           CONCAT(ROUND(((SUM(three_pointers_made) / SUM(three_pointers_attempted))*100), 1), '%') AS 3p_pct,
           CONCAT(ROUND(((SUM(free_throws_made) / SUM(free_throws_attempted))*100), 1), '%') AS ft_pct
	FROM player_game_logs pgl
	JOIN player_information pi ON pi.player_id = pgl.player_id
	WHERE game_date BETWEEN '2022-10-18' AND '2023-02-16' AND active_inactive = 'Active'
	GROUP BY 1, 4
	UNION
	SELECT pgl.player_id,
		   first_name,
           last_name,
           team_id,
           'Post-All Star Break' AS pre_or_post_allstar,
           COUNT(*) AS games_played,
           ROUND(AVG(points), 1) AS ppg,
           ROUND(AVG(assists), 1) AS apg,
           ROUND(AVG(offensive_rebounds+defensive_rebounds), 1) AS rpg,
           CONCAT(ROUND(((SUM(field_goals_made) / SUM(field_goals_attempted))*100), 1), '%') AS fg_pct,
           CONCAT(ROUND(((SUM(three_pointers_made) / SUM(three_pointers_attempted))*100), 1), '%') AS 3p_pct,
           CONCAT(ROUND(((SUM(free_throws_made) / SUM(free_throws_attempted))*100), 1), '%') AS ft_pct
	FROM player_game_logs pgl
	JOIN player_information pi ON pi.player_id = pgl.player_id
	WHERE game_date BETWEEN '2023-02-23' AND '2023-04-09' AND active_inactive = 'Active'
	GROUP BY 1, 4)
SELECT CONCAT(first_name,' ', last_name) AS Full_Name,
       Team_ID,
       pre_or_post_allstar AS 'Pre/Post All-Star Break',
       Games_Played,
       PPG,
       APG,
       RPG,
       FG_PCT,
       3P_PCT,
       FT_PCT
FROM pre_post_all_star
ORDER BY player_id, 3 DESC;

-- Showing the most points, assists and rebounds by each player against each team during the regular season, dependent on the team the player played for
WITH opp_team_names AS (
	SELECT DISTINCT(team_name) AS opp_team_name,
		   opp_team_id
	FROM player_game_logs pgl
	JOIN team t ON t.team_id = pgl.opp_team_id
	ORDER BY 1)
		SELECT CONCAT(pi.first_name,' ', pi.last_name) AS 'Full Name',
			   t.team_name AS 'Team Name',
               sub.opp_team_name AS "Opponent's Team Name",
               MAX(points) AS 'Most Points',
               MAX(assists) AS 'Most Assists',
               MAX(offensive_rebounds + defensive_rebounds) AS 'Most Rebounds'
		FROM
				(SELECT opp_team_name,
						pgl.*
				 FROM opp_team_names otn
				 JOIN player_game_logs pgl ON pgl.opp_team_id = otn.opp_team_id) sub
		JOIN team t ON t.team_id = sub.team_id
		JOIN player_information pi ON pi.player_id = sub.player_id
		WHERE active_inactive = 'Active' AND game_type = 'Regular Season'
		GROUP BY sub.player_id, t.team_name, sub.opp_team_name
		ORDER BY sub.player_id, sub.opp_team_name, t.team_name;

-- Showing the game stats for each player's season high and season low in points during the regular season
SELECT CONCAT(first_name,' ', last_name) AS Full_Name,
	   Game_Type,
       Game_Date,
       Team_ID,
       Opp_Team_ID,
       home_away AS 'Home/Away',
       win_loss AS 'Win/Loss',
       ROUND(minutes_played, 1) AS Minutes_Played,
       field_goals_made AS FGM,
       field_goals_attempted AS FGA,
       CONCAT(ROUND((field_goals_percentage*100), 1), '%') AS FG_PCT,
       three_pointers_made AS 3PM,
       three_pointers_attempted AS 3PA,
       CONCAT(ROUND((three_pointers_percentage*100), 1), '%') AS 3P_PCT,
       free_throws_made AS FTM,
       free_throws_attempted AS FTA,
       CONCAT(ROUND((free_throws_percentage*100), 1), '%') AS FT_PCT,
       CONCAT(ROUND((points / (2*(field_goals_attempted + (0.44*free_throws_attempted))))*100, 1), '%') AS TS_PCT,
       'True shooting percentage considers 2 point field goals, 3 point field goals and free throws' AS TS_Description,
       (offensive_rebounds + defensive_rebounds) AS REB,
       assists AS AST,
       steals AS STL,
       blocks AS BLK,
       turnovers AS TOV,
       fouls AS FLS,
       points AS PTS,
	  (CASE WHEN plus_minus LIKE '-%' THEN plus_minus ELSE CONCAT('+', plus_minus) END) AS '+/-'
FROM player_game_logs pgl
JOIN player_information pi ON pi.player_id = pgl.player_id
WHERE game_type = 'Regular Season' AND (
	  (pgl.player_id, points) IN (SELECT player_id, MIN(points)
								  FROM player_game_logs
								  GROUP BY player_id)
							  OR
	  (pgl.player_id, points) IN (SELECT player_id, MAX(points)
								  FROM player_game_logs
								  GROUP BY player_id))
ORDER BY pgl.player_id, points DESC;

-- Showing the game stats of each player's 15th win of the regular season
SELECT CONCAT(first_name,' ', last_name) AS Full_Name,
       Game_Type,
       Game_Date,
	   Team_ID,
       Opp_Team_ID,
       home_away AS 'Home/Away',
       win_loss AS 'Win/Loss',
       ROUND(minutes_played, 1) AS Minutes_Played,
       field_goals_made AS FGM,
       field_goals_attempted AS FGA,
       CONCAT(ROUND((field_goals_percentage*100), 1), '%') AS FG_PCT,
       three_pointers_made AS 3PM,
       three_pointers_attempted AS 3PA,
       CONCAT(ROUND((three_pointers_percentage*100), 1), '%') AS 3P_PCT,
       free_throws_made AS FTM,
       free_throws_attempted AS FTA,
       CONCAT(ROUND((free_throws_percentage*100), 1), '%') AS FT_PCT,
       (offensive_rebounds + defensive_rebounds) AS REB,
       assists AS AST,
       steals AS STL,
       blocks AS BLK,
       turnovers AS TOV,
       fouls AS FLS,
       points AS PTS,
	  (CASE WHEN plus_minus LIKE '-%' THEN plus_minus ELSE CONCAT('+', plus_minus) END) AS '+/-'
FROM
		(SELECT *,
				ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY game_date) as row_num
		FROM player_game_logs
		WHERE win_loss = 'W' AND game_type = 'Regular Season') sub
JOIN player_information pi ON pi.player_id = sub.player_id
WHERE row_num = 15
ORDER BY points DESC;

-- Showing the number of home games played, away games played, odd point games, even point games, total games played and total games missed, along with their percentages, for each player during the regular season
SELECT pgl.Player_ID,
	   SUM(pgl.home_away = 'Home') AS Num_Home_Games_Played,
       Total_Home_Games,
       CONCAT((ROUND(((SUM(pgl.home_away = 'Home') / total_home_games)*100),1)), '%') AS Percentage_Home_Games_Played,
       SUM(pgl.home_away = 'Away') AS Num_Away_Games_Played,
       Total_Away_Games,
       CONCAT((ROUND(((SUM(pgl.home_away = 'Away') / total_away_games)*100),1)), '%') AS Percentage_Away_Games_Played,
	   Num_Odd_Point_games,
       CONCAT((ROUND(((SUM(points % 2 = 1) / COUNT(*))*100), 1)), '%') AS Percentage_Odd_Point_Games,
       Num_Even_Point_Games,
	   CONCAT((ROUND(((SUM(points % 2 = 0) / COUNT(*))*100), 1)), '%') AS Percentage_Even_Point_Games,
       Num_Games_Played,
       CONCAT((ROUND(((num_games_played / total_games)*100), 1)), '%') AS Percentage_Games_Played,
       Num_Games_Missed,
       CONCAT((ROUND(((num_games_missed / total_games)*100), 1)), '%') AS Percentage_Games_Missed,
       Total_Games,
       (CASE WHEN pgl.player_id = 1 THEN 'Kevin Durant was unavailable for 2 of the 82 regular season games due to a trade mid-season'
			 WHEN pgl.player_id = 2 THEN 'Kyrie Irving was unavailable for 2 of the 82 regular season games due to a trade mid-season'
             ELSE 'Devin Booker was available for all 82 games of the regular season' END) AS Description
FROM player_game_logs pgl
JOIN (SELECT player_id,
			 SUM(home_away = 'Home') AS total_home_games,
             SUM(home_away = 'Away') AS total_away_games,
             SUM(active_inactive = 'Active') AS num_games_played,
             SUM(active_inactive = 'Inactive') AS num_games_missed,
             SUM(points % 2 = 1) AS num_odd_point_Games,
             SUM(points % 2 = 0) AS num_even_point_games,
             COUNT(*) AS total_games
	  FROM player_game_logs
      WHERE game_type = 'Regular Season'
      GROUP BY player_id) sub
ON sub.player_id = pgl.player_id
WHERE active_inactive = 'Active' AND game_type = 'Regular Season'
GROUP BY 1;

-- Showing the number of games each player scored less than 10, in the 10s, 20s, 30s, 40s, 50s, along with their win percentage, and the percentage of games each player had in each point group during the regular season
SELECT Player_ID,
	   Point_Groups,
       Num_Won_Games,
       Num_Lost_Games,
       Total_Games_Group,
	   (CASE WHEN ROUND(((num_won_games / total_games_group)*100), 1) LIKE '%.0' THEN CONCAT((ROUND(((num_won_games/total_games_group)*100), 0)), '%') 
			 ELSE CONCAT((ROUND(((num_won_games / total_games_group)*100), 1)), '%') END)
            AS Winning_Percentage,
	   (CASE WHEN ROUND(((total_games_group / SUM(total_games_group) OVER(PARTITION BY player_id))*100), 1) LIKE '%.0' THEN CONCAT((ROUND(((total_games_group / SUM(total_games_group) OVER(PARTITION BY player_id))*100), 0)), '%') 
			 ELSE CONCAT((ROUND(((total_games_group / SUM(total_games_group) OVER(PARTITION BY player_id))*100), 1)), '%') END)
             AS Point_Groups_Games_Percentage,
	   SUM(total_games_group) OVER(PARTITION BY player_id) AS Total_Games_Played
FROM
	(SELECT player_id,
		   (CASE WHEN points < 10 THEN '<10'
				 WHEN points BETWEEN 10 AND 19 THEN '10-19'
				 WHEN points BETWEEN 20 AND 29 THEN '20-29'
				 WHEN points BETWEEN 30 AND 39 THEN '30-39'
				 WHEN points BETWEEN 40 AND 49 THEN '40-49'
				 ELSE '50-59' END) AS point_groups,
            SUM(win_loss = 'W') AS num_won_games,
            SUM(win_loss = 'L') AS num_lost_games,
            COUNT(*) total_games_group
	 FROM player_game_logs
	 WHERE active_inactive = 'Active' AND game_type = 'Regular Season'
	 GROUP BY player_id, point_groups
	 ORDER BY player_id, point_groups = '<10' DESC, point_groups) sub;
     
-- Showing the most common number of points scored by each player during the regular season
WITH common_points_table AS (
	SELECT player_id,
		   points,
           COUNT(*) AS count
	FROM player_game_logs
	WHERE active_inactive = 'Active' AND game_type = 'Regular Season'
	GROUP BY 1, 2
	ORDER BY 1, 3 DESC)
SELECT Player_ID,
	   Points,
       count AS Num_Of_Times_Scored
FROM common_points_table
WHERE (player_id, count) IN (SELECT player_id, MAX(count)
							 FROM (SELECT * FROM common_points_table) sub
							 GROUP BY player_id)
ORDER BY 1, 2 DESC;

-- Showing the most days missed in-between games for each player, including the start date, end date and reasoning
WITH days_missed AS (
	 SELECT pgl1.player_id,
		    pgl1.game_date,
			DATEDIFF(MIN(pgl2.game_date), pgl1.game_date) AS diff,
			LEAD(pgl1.game_id) OVER (PARTITION BY player_id) - pgl1.game_id - 1 AS game_diff,
            MIN(pgl2.game_date) AS end_date
	 FROM player_game_logs pgl1
     JOIN player_game_logs pgl2 ON pgl2.player_id = pgl1.player_id AND pgl2.game_date > pgl1.game_date 
     WHERE (pgl1.active_inactive = 'Active' AND pgl1.game_type = 'Regular Season') AND
		   (pgl2.active_inactive = 'Active' AND pgl2.game_type = 'Regular Season')
     GROUP BY pgl1.player_id, pgl1.game_date, pgl1.game_id),
max_diff_extraction AS (
	SELECT player_id,
		   MAX(game_diff) AS max_game_diff,
		   MAX(diff) AS max_diff
    FROM days_missed
    GROUP BY 1),
final_table AS (
	SELECT *
    FROM days_missed
    WHERE (player_id, game_diff, diff) IN (SELECT * FROM max_diff_extraction))
SELECT CONCAT(first_name, ' ', last_name) AS Full_Name,
       diff AS Days_Missed,
       game_diff AS Games_Missed,
       game_date AS Start_Date,
       end_date AS End_Date,
	  (CASE WHEN ft.player_id = 1 THEN 'Injury'
			WHEN ft.player_id = 2 THEN 'Suspension'
            WHEN ft.player_id = 3 THEN 'Injury'
       END) AS Reason
FROM final_table ft
JOIN player_information pi ON ft.player_id = pi.player_id;

-- Showing each player's longest win streak, including the total days in between, the start date, the end date, the first opponent and the last opponent
WITH new_streak AS (
	SELECT player_id,
		   game_date,
           team_id,
           opp_team_id,
           win_loss,
		   (CASE WHEN win_loss = 'W' AND LAG(win_loss) OVER(PARTITION BY player_id ORDER BY game_date) = 'L' THEN 1 ELSE 0 END) AS new_streak
    FROM player_game_logs
    WHERE game_type = 'Regular Season'),
streak_number AS (
	SELECT *,
		   SUM(new_streak) OVER (PARTITION BY player_id ORDER BY game_date) AS streak_num
	FROM new_streak
	WHERE win_loss = 'W'),
streak_length AS (
	SELECT player_id,
		   streak_num,
           COUNT(*) AS count
	FROM streak_number
	GROUP by 1, 2),
first_table AS (
	SELECT sn.*,
		   sl.count
	FROM streak_number sn
	JOIN streak_length sl ON sl.player_id = sn.player_id AND sl.streak_num = sn.streak_num),
max_streak_extraction AS (
	SELECT player_id,
		   MAX(count) AS longest_win_streak
	FROM first_table
	GROUP BY 1),
second_table AS (
	SELECT player_id,
		   streak_num,
           count,
           MIN(game_date) AS min_date,
           MAX(game_date) AS max_date
    FROM first_table
    GROUP BY 1, 2),
min_game_date_table AS (
	SELECT *
    FROM first_table
    WHERE (player_id, streak_num, game_date) IN (SELECT player_id, streak_num, min_date FROM second_table)),
max_game_date_table AS (
	SELECT *
    FROM first_table
    WHERE (player_id, streak_num, game_date) IN (SELECT player_id, streak_num, max_date
												 FROM second_table)),
final_table AS (
	SELECT min.player_id,
           min.team_id AS min_team_id,
		   min.game_date AS min_date,
           min.opp_team_id AS min_opp_team_id,
           max.game_date AS max_date,
           max.opp_team_id AS max_opp_team_id,
           max.count AS win_streak
    FROM min_game_date_table min
    JOIN max_game_date_table max ON max.player_id = min.player_id AND max.count = min.count)
SELECT CONCAT(first_name, ' ', last_name) AS Full_Name,
	   min_team_id AS Team_ID,
	   min_date AS Start_Date,
       min_opp_team_id AS First_Opp_Team_ID,
       max_date AS End_Date,
       max_opp_team_id AS Last_Opp_Team_ID,
	   win_streak AS Win_Streak,
       DATEDIFF(max_date, min_date) AS Total_Days
FROM final_table ft
JOIN player_information pi ON pi.player_id = ft.player_id
WHERE (ft.player_id, win_streak) IN (SELECT player_id, longest_win_streak
									 FROM max_streak_extraction);

-- Showing each player's longest game streak of scoring at least 30 or more points and the total points accumulated
WITH new_streak AS (
	SELECT player_id,    
		   game_date,
           team_id,
           opp_team_id,
           home_away,
           points,
		   (CASE WHEN points >= 30 AND
					  (LAG(points) OVER(PARTITION BY player_id ORDER BY game_date) <30 OR LAG(points) OVER(PARTITION BY player_id ORDER BY game_date) IS NULL)
                      THEN 1 ELSE 0 END) AS new_streak
    FROM player_game_logs
    WHERE game_type = 'Regular Season'),
streak_number AS (
	SELECT *,
		   SUM(new_streak) OVER (PARTITION BY player_id ORDER BY game_date) AS streak_num
	FROM new_streak
	WHERE points >= 30),
sum_of_streaks AS (
	SELECT *,
    SUM(points) OVER(PARTITION BY player_id, streak_num ORDER BY game_date) AS streak_sum
    FROM streak_number),
streak_length AS (
	SELECT player_id,
		   streak_num,
		   COUNT(*) AS streak_length
	FROM sum_of_streaks
    GROUP BY 1, 2),
max_streak_extraction AS (
	SELECT player_id,
           MAX(streak_length)
	FROM streak_length
    GROUP BY 1)
SELECT ss.Player_ID,
	   ss.Game_Date,
       ss.Team_ID,
       ss.Opp_Team_ID,
       ss.home_away AS 'Home/Away',
       Points,
       streak_sum AS Total_Points
FROM sum_of_streaks ss
JOIN streak_length sl ON sl.player_id = ss.player_id AND sl.streak_num = ss.streak_num
WHERE (ss.player_id, sl.streak_length) IN (SELECT *
										   FROM max_streak_extraction);

-- Showing the states that have more than one team
SELECT Team_ID,
	   Team_Name,
       City,
       t.State_Province,
       Country
FROM team t
JOIN (SELECT state_province,
			 COUNT(*) AS num_of_teams
	  FROM team
      GROUP BY 1
      HAVING COUNT(*) > 1) sub
ON sub.state_province = t.state_province
ORDER BY sub.num_of_teams DESC, 4, 2;