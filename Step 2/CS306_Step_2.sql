CREATE DATABASE world_analysis;

USE world_analysis;

-- Countries Table
CREATE TABLE Countries (
    country_id INTEGER AUTO_INCREMENT,
    country_name VARCHAR(255) NOT NULL,
    country_code VARCHAR(255) NOT NULL,
    PRIMARY KEY (country_id)
);

-- Population Table
CREATE TABLE Population (
	country_population_id INTEGER NOT NULL PRIMARY KEY,
	country_population_name VARCHAR(255) NOT NULL,
    years INTEGER,
    population_total INTEGER,
    population_age_1 INTEGER,
    population_age_1to4 INTEGER,
    population_age_5to9 INTEGER,
    population_age_10to14 INTEGER,
    population_age_15to19 INTEGER,
    population_age_20to29 INTEGER,
    population_age_30to39 INTEGER,
    population_age_40to49 INTEGER,
    population_age_50to59 INTEGER,
    population_age_60to69 INTEGER,
    population_age_70to79 INTEGER,
    population_age_80to89 INTEGER,
    population_age_90to99 INTEGER,
    population_age_over_100 INTEGER
);

-- Economy Table
CREATE TABLE Economy (
    country_economy_id INTEGER,
    country_economy_name VARCHAR(255) NOT NULL,
    country_economy_code VARCHAR(255) NOT NULL,
    years INTEGER,
    share_of_pop_below_poverty REAL,
    PRIMARY KEY (country_economy_id)
);

-- Terrorism Table
CREATE TABLE Terrorism (
	terror_id INTEGER NOT NULL,
	terror_country_name VARCHAR(255) NOT NULL, 
    terror_country_code VARCHAR(255) NOT NULL,
    years INTEGER,
    death INTEGER,
    PRIMARY KEY (terror_id)
);

-- Immigrants Table (Weak Entity)
CREATE TABLE Migration (
	migration_id INTEGER NOT NULL PRIMARY KEY,
    years INTEGER,
    country_migration_name VARCHAR(255) NOT NULL,
    refugee_amount INTEGER,
    net_migration INTEGER
);

LOAD DATA LOCAL INFILE 'D:/School/fatalities-from-terrorism-new.csv' 
INTO TABLE Terrorism 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/world-data-all-new.csv' 
INTO TABLE Population 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE Population;

SELECT * FROM Migration;

INSERT INTO Countries (country_name, country_code) SELECT DISTINCT terror_country_name, terror_country_code FROM Terrorism;

ALTER TABLE Population
ADD country_population_code VARCHAR(255);

UPDATE Population
SET country_population_code = (SELECT country_code FROM Countries WHERE Countries.country_name = Population.country_population_name);

ALTER TABLE Migration
ADD country_migration_code VARCHAR(255);

UPDATE Migration
SET country_migration_code = (SELECT country_code FROM Countries WHERE Countries.country_name = Migration.country_migration_name);

ALTER TABLE Migration
DROP country_migration_code;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/poverty_new.csv' 
INTO TABLE Economy 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET GLOBAL general_log = 'ON';
