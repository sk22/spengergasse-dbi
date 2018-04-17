USE tennisdb;

-- Task 1

SELECT * FROM p_players
  WHERE p_playerno IN (SELECT pe_p_playerno FROM pe_penalties)
UNION
SELECT * FROM p_players
  WHERE p_playerno IN (SELECT t_p_playerno FROM t_teams);


-- Task 2

SELECT * FROM p_players
  WHERE p_playerno IN (SELECT pe_p_playerno FROM pe_penalties)
UNION
SELECT * FROM p_players
  WHERE p_playerno IN (SELECT t_p_playerno FROM t_teams)
UNION
SELECT * FROM p_players
  WHERE p_town = "Stratford";


-- Task 3.1

SELECT x.p_playerno, x.p_year_of_birth
  FROM (SELECT * FROM p_players WHERE p_town = "Stratford") x
  INNER JOIN (SELECT * FROM p_players WHERE p_year_of_birth > 1960) y
    ON x.p_playerno = y.p_playerno;


-- Task 3.2 (Oracle)

-- SELECT * FROM p_players WHERE p_town = "Stratford")
-- INTERSECT
-- SELECT * FROM p_players WHERE p_year_of_birth > 1960;


-- Task 3.3

SELECT p_playerno, p_year_of_birth FROM p_players
  WHERE p_town = "Stratford"
    AND p_year_of_birth > 1960;


-- Task 4.1 (Oracle)

-- SELECT p_playerno FROM p_players
--   WHERE p_playerno IN (SELECT pe_p_playerno FROM pe_penalties)
-- INTERSECT
-- SELECT p_playerno FROM p_players
--   WHERE p_playerno IN (SELECT t_p_playerno FROM t_teams)


-- Task 4.2

SELECT p_playerno FROM p_players
  WHERE p_playerno IN (SELECT pe_p_playerno FROM pe_penalties)
    AND p_playerno IN (SELECT t_p_playerno FROM t_teams);


-- Task 5.1

-- SELECT p_playerno, p_year_of_birth FROM p_players
--   WHERE p_town = "Stratford"
-- MINUS
-- SELECT p_playerno, p_year_of_birth FROM p_players
--   WHERE p_year_of_birth < 1960;


-- Task 5.2

SELECT x.p_playerno, x.p_year_of_birth
  FROM (SELECT * FROM p_players WHERE p_town = "Stratford") x
  RIGHT JOIN (SELECT * FROM p_players WHERE p_year_of_birth < 1960) y
    ON x.p_playerno = y.p_playerno;


-- Task 6.1 (Oracle)

-- SELECT p_playerno
--   FROM p_players
--   WHERE p_playerno IN (SELECT pe_p_playerno FROM pe_penalties)
-- MINUS
-- SELECT p_playerno
--   FROM p_players
--   WHERE p_playerno IN (SELECT t_p_playerno FROM t_teams);


-- Task 6.1 (Oracle)

-- SELECT p_playerno
--   FROM p_players
--   WHERE p_playerno IN (SELECT pe_p_playerno FROM pe_penalties)
-- MINUS
-- SELECT p_playerno
--   FROM p_players
--   WHERE p_playerno IN (SELECT t_p_playerno FROM t_teams);


-- Task 6.2

SELECT x.p_playerno
  FROM (
    SELECT p_playerno
    FROM p_players
    WHERE p_playerno IN (SELECT pe_p_playerno FROM pe_penalties)
  ) x
  RIGHT JOIN (
    SELECT p_playerno
    FROM p_players
    WHERE p_playerno IN (SELECT t_p_playerno FROM t_teams)
  ) y ON x.p_playerno = y.p_playerno;


