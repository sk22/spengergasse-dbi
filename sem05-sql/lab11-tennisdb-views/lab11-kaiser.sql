USE tennisdb;

-- Task 1

DROP VIEW IF EXISTS towns_view;

CREATE VIEW towns_view AS
SELECT DISTINCT p_town FROM p_players;

-- Task 2

DROP VIEW IF EXISTS players_league_view;

CREATE VIEW players_league_view AS
SELECT p_playerno, p_leagueno FROM p_players
WHERE p_leagueno IS NOT NULL;

-- Task 3

DELETE FROM players_league_view
WHERE p_leagueno = 7060;

-- Task 4

DROP VIEW IF EXISTS league_numbers_view;

CREATE VIEW league_numbers_view AS
SELECT DISTINCT p_leagueno FROM players_league_view;

-- Task 5

DROP VIEW IF EXISTS stratford_players_info_view;

CREATE VIEW stratford_players_info_view AS
SELECT p_playerno, 

-- Task 6

DROP VIEW IF EXISTS players_in_towns_view;

CREATE VIEW players_in_towns_view (t_town, t_players) AS
SELECT p_town, count(p_playerno);


