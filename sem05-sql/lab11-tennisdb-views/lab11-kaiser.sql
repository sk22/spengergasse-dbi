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
