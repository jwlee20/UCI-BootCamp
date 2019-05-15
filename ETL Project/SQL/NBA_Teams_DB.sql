-- Create and use NBA_Teams_db
CREATE DATABASE NBA_Teams_db;
USE NBA_Teams_db;

-- Adding Primary Keys to keep referential integrity
ALTER TABLE team_stats
ADD CONSTRAINT Rank PRIMARY KEY (Rank);

ALTER TABLE team_eval
ADD CONSTRAINT Team PRIMARY KEY (Team);

-- Adding Foreign Key to keep referential integrity
ALTER TABLE team_misc
ADD FOREIGN KEY team_misc(Rank) REFERENCES team_stats(Rank);

ALTER TABLE team_misc
ADD FOREIGN KEY team_misc(Team) REFERENCES team_eval(Team);

ALTER TABLE team_stats
ADD FOREIGN KEY team_stats(Team) REFERENCES team_eval(Team);

-- Changing to NOT NULL
ALTER TABLE team_misc
CHANGE Rank Rank INT NOT NULL;

-- Change from TEXT to VARCHAR and PRIMARY KEY
ALTER TABLE team_eval
CHANGE Team Team VARCHAR(40) NOT NULL PRIMARY KEY;

-- Change from TEXT to VARCHAR to add Foreign Key
ALTER TABLE team_misc
CHANGE Team Team VARCHAR(40) NOT NULL;

ALTER TABLE team_stats
CHANGE Team Team VARCHAR(40) NOT NULL;

-- Join tables on Rank
SELECT *
FROM team_stats, team_misc
WHERE team_stats.Rank = team_misc.Rank;

-- Gives us information on our tables
DESCRIBE team_stats;
DESCRIBE team_misc; 
DESCRIBE team_eval;

-- Make sure all of our data is there
SELECT *
FROM team_stats;

SELECT *
FROM team_misc;

SELECT *
FROM team_eval;

-- DROP TABLE team_stats;
-- DROP TABLE team_misc;
-- DROP TABLE team_eval;

-- Join our stat and misc tables with team eval table
SELECT *
FROM team_eval, team_stats
WHERE team_eval.ID = team_stats.ID;

SELECT *
FROM team_misc, team_stats
WHERE team_misc.Team = team_stats.Team;