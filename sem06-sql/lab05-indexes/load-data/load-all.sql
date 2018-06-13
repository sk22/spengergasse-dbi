USE schooldb_indexes;
SET profiling = 1;

SET FOREIGN_KEY_CHECKS = 0;

SELECT 21000 AS Records, 1000 AS Klassen, 3420000 AS Schueler, NOW() AS Date; 
SOURCE load-21000.sql;

SELECT 210000 AS Records, 10000 AS Klassen, 200000 AS Schueler, NOW() AS Date; 
SOURCE load-210000.sql;

SELECT 87880 + 1757600 AS Records, 87880 AS Klassen, 1757600 AS Schueler, NOW() AS Date; 
SOURCE load-2100000.sql;

SET FOREIGN_KEY_CHECKS = 1;

SHOW profiles;

