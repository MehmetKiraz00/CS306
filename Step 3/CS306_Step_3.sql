CREATE DATABASE world_analysis;

USE world_analysis;

-- Countries Table
CREATE TABLE Countries (
    country_id INTEGER ,
    country_name VARCHAR(255) NOT NULL,
    country_code VARCHAR(255) NOT NULL,
    years INTEGER,
    PRIMARY KEY (country_id)
);

SELECT * FROM countries;

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

-- Immigrants Table 
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

DROP TABLE test;

SELECT * FROM economy;

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

-- <----------------------- STEP 3 ------------------------> --

-- ALTER TABLE MY_TABLE ADD id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

-- Military Table Main
CREATE TABLE Military (
    country_military_name VARCHAR(255) NOT NULL,
    country_military_code VARCHAR(255) NOT NULL,
    years INTEGER,
    total_armed_personel INTEGER
);

DROP TABLE Military_4;

SELECT * FROM Military order by country_military_code;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/armed-forces-personnel-new.csv' 
INTO TABLE Military 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Military_2 (
    country_military_name VARCHAR(255) NOT NULL,
    country_military_code VARCHAR(255) NOT NULL,
    years INTEGER,
    armed_personel_share_pop DOUBLE NOT NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/armed-forces-personnel-percent-new.csv' 
INTO TABLE Military_2
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


ALTER TABLE Military_2 MODIFY COLUMN armed_personel_share_pop DECIMAL(10,8);

CREATE TABLE Military_3 (
    country_military_name VARCHAR(255) NOT NULL,
    country_military_code VARCHAR(255) NOT NULL,
    years INTEGER,
    armed_personel_share_labor DOUBLE NOT NULL
);

ALTER TABLE Military_3 MODIFY COLUMN armed_personel_share_labor DECIMAL(10,8);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/armed-forces-personnel-of-total-labor-force-new.csv' 
INTO TABLE Military_3
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM military_3;

CREATE TABLE Military_4 (
    country_military_name VARCHAR(255) NOT NULL,
    country_military_code VARCHAR(255) NOT NULL,
    years INTEGER,
    military_expenditure_share_gdp DOUBLE 
);

ALTER TABLE Military_4 MODIFY COLUMN military_expenditure_share_gdp DECIMAL(10,8);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/military-expenditure-as-a-share-of-gdp-long-new.csv' 
INTO TABLE Military_4
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Military_5 (
    country_military_name VARCHAR(255) NOT NULL,
    country_military_code VARCHAR(255) NOT NULL,
    years INTEGER,
    military_expenditure DOUBLE 
);

ALTER TABLE Military_5 MODIFY COLUMN military_expenditure REAL;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/military-expenditure-total-new.csv' 
INTO TABLE Military_5
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Economy_2 (
    country_economy_name VARCHAR(255) NOT NULL,
    country_economy_code VARCHAR(255) NOT NULL,
    years INTEGER,
    gdp_growth REAL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/gdp-per-capita-growth-new.csv' 
INTO TABLE Economy_2
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE economy_2;

SELECT * FROM happiness;

CREATE TABLE Corruption (
    country_corruption_name VARCHAR(255) NOT NULL,
    country_corruption_code VARCHAR(255) NOT NULL,
    years INTEGER,
    corruption_percentage INTEGER
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/corruption-perception-index-new.csv' 
INTO TABLE Corruption
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Happiness (
    country_happiness_name VARCHAR(255) NOT NULL,
    country_happiness_code VARCHAR(255) NOT NULL,
    years INTEGER,
    happiness_rate_out_of_10 REAL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/happiness-cantril-ladder-new.csv' 
INTO TABLE happiness
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE RnD (
    country_RnD_name VARCHAR(255) NOT NULL,
    country_RnD_code VARCHAR(255) NOT NULL,
    years INTEGER,
    RnD_expenditure_share_gdp REAL
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/research-spending-gdp-new.csv' 
INTO TABLE rnd
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE economy_2
RENAME COLUMN years TO years_2;

-- <Added all the new data files now to merge them with relevant tables accordingly.....>

CREATE VIEW Military_Details AS
SELECT 
	m1.country_military_name, 
    m1.country_military_code, 
    m1.years, 
    m1.total_armed_personel, 
    m2.armed_personel_share_pop, 
    m3.armed_personel_share_labor, 
    m4.military_expenditure_share_gdp, 
    m5.military_expenditure   
	FROM 
		military m1
	JOIN 
		military_2 m2 
    ON 
		m1.years = m2.years_2 AND m1.country_military_code = m2.country_military_2_code
    JOIN 
		military_3 m3 
    ON 
		m1.years = m3.years_3 AND m1.country_military_code = m3.country_military_3_code
    JOIN 
		military_4 m4 
    ON 
		m1.years = m4.years_4 AND m1.country_military_code = m4.country_military_4_code
    JOIN 
		military_5 m5 
    ON 
		m1.years = m5.years_5 AND m1.country_military_code = m5.country_military_5_code
ORDER BY country_military_code;

SELECT * FROM TERRORISM;

DROP view terrorism_happiness;

ALTER TABLE happiness ADD id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

CREATE VIEW Migration_Terrorism AS
SELECT
    c.country_id,
    c.country_name,
    c.country_code,
    c.years,
    m.refugee_amount,
    m.net_migration,
    t.death
FROM
    countries c
JOIN
    migration m
ON
    c.country_name = m.country_migration_name AND c.years = m.years
JOIN
    terrorism t
ON
    c.country_name = t.terror_country_name AND c.years = t.years
ORDER BY country_code;	

SELECT * FROM Migration_Terrorism;

CREATE VIEW Poverty_Terrorism AS
SELECT
    c.country_id,
    c.country_name,
    c.country_code,
    c.years,
    e.share_of_pop_below_poverty,
    t.death
FROM
    countries c
JOIN
    economy e
ON
    c.country_name = e.country_economy_name AND c.years = e.years
JOIN
    terrorism t
ON
    c.country_name = t.terror_country_name AND c.years = t.years
ORDER BY country_code;

DROP VIEW migration_poverty;

CREATE VIEW Poverty_MilitaryExpenditure AS
SELECT
    c.country_id,
    c.country_name,
    c.country_code,
    c.years,
    e.share_of_pop_below_poverty,
    m.military_expenditure_share_gdp
FROM
    countries c
JOIN
    economy e
ON
    c.country_name = e.country_economy_name AND c.years = e.years
JOIN
    military_4 m
ON
    c.country_name = m.country_military_4_name AND c.years = m.years_4
ORDER BY country_code;

SELECT * FROM Migration_Poverty;

CREATE VIEW Migration_Poverty AS
SELECT
    c.country_id,
    c.country_name,
    c.country_code,
    c.years,
    e.share_of_pop_below_poverty,
    m.refugee_amount,
    m.net_migration
FROM
    countries c
JOIN
    economy e
ON
    c.country_name = e.country_economy_name AND c.years = e.years
JOIN
    migration m
ON
    c.country_name = m.country_migration_name AND c.years = m.years
ORDER BY country_code;

CREATE VIEW Terrorism_MilitaryExpenditure AS
SELECT
    c.country_id,
    c.country_name,
    c.country_code,
    c.years,
    t.death,
    m.military_expenditure_share_gdp
FROM
    countries c
JOIN
    terrorism t
ON
    c.country_name = t.terror_country_name AND c.years = t.years
JOIN
    military_4 m
ON
    c.country_name = m.country_military_4_name AND c.years = m.years_4
ORDER BY country_code and years;

SELECT * FROM terrorism_militaryexpenditure
ORDER BY country_id;

CREATE VIEW Terrorism_Happiness AS
SELECT
    c.country_id,
    c.country_name,
    c.country_code,
    c.years,
    t.death,
    h.happiness_rate_out_of_10
FROM
    countries c
JOIN
    terrorism t
ON
    c.country_name = t.terror_country_name AND c.years = t.years
JOIN
    happiness h
ON
    c.country_name = h.country_happiness_name AND c.years = h.years
ORDER BY country_id;

SELECT * FROM terrorism_happiness
ORDER BY country_id;

CREATE VIEW Happiness_GDP AS
SELECT
    c.country_id,
    c.country_name,
    c.country_code,
    c.years,
    h.happiness_rate_out_of_10,
    e.gdp_growth
FROM
    countries c
JOIN
    economy_2 e
ON
    c.country_name = e.country_economy_2_name AND c.years = e.years_2
JOIN
    happiness h
ON
    c.country_name = h.country_happiness_name AND c.years = h.years
ORDER BY country_id;

SELECT * FROM happiness_gdp
ORDER BY country_id;

CREATE VIEW GDP_RnD AS
SELECT
    c.country_id,
    c.country_name,
    c.country_code,
    c.years,
    e.gdp_growth,
    r.RnD_expenditure_share_gdp
FROM
    countries c
JOIN
    economy_2 e
ON
    c.country_name = e.country_economy_2_name AND c.years = e.years_2
JOIN
    rnd r
ON
    c.country_name = r.country_RnD_name AND c.years = r.years
ORDER BY country_id;

SELECT * FROM gdp_rnd
ORDER BY country_id;

CREATE VIEW Happiness_Corruption AS
SELECT
    c.country_id,
    c.country_name,
    c.country_code,
    c.years,
    h.happiness_rate_out_of_10,
    cr.corruption_percentage
FROM
    countries c
JOIN
    corruption cr
ON
    c.country_name = cr.country_corruption_name AND c.years = cr.years
JOIN
    happiness h
ON
    c.country_name = h.country_happiness_name AND c.years = h.years
ORDER BY country_id;

SELECT * FROM happiness_corruption
ORDER BY country_id;



ALTER TABLE Migration
ADD CONSTRAINT ck_refugee_amount_range
CHECK (refugee_amount BETWEEN 0 AND 6608918);

DELIMITER //
CREATE TRIGGER tr_enforce_refugee_amount_range_before_insert
BEFORE INSERT ON Migration
FOR EACH ROW
BEGIN
IF NEW.refugee_amount < 0 THEN
SET NEW.refugee_amount = 0;
ELSEIF NEW.refugee_amount > 6608918 THEN
SET NEW.refugee_amount = 6608918;
END IF;
END;
//
DELIMITER ;

DROP TRIGGER IF EXISTS tr_enforce_refugee_amount_range_before_insert;

SELECT MIN(refugee_amount) AS min_refugee, MAX(refugee_amount) AS max_refugee
FROM Migration;

SELECT * FROM Migration;

DELIMITER //
CREATE TRIGGER tr_enforce_refugee_amount_range_before_update
BEFORE UPDATE ON Migration
FOR EACH ROW
BEGIN
IF NEW.refugee_amount < 0 THEN
SET NEW.refugee_amount = 0;
ELSEIF NEW.refugee_amount > 6608918 THEN
SET NEW.refugee_amount = 6608918;
END IF;
END;
//
DELIMITER ;

SELECT * FROM Migration;

INSERT INTO Migration (migration_id, years, country_migration_name, refugee_amount, net_migration, country_migration_code)
VALUES (534, 2023, 'Turkey', 7000000, 0, 'TUR');


DELIMITER //
CREATE PROCEDURE GetMilitaryDataByCountryCode(IN country_code VARCHAR(3))
BEGIN
    SELECT
        md.country_military_name,
        md.country_military_code,
        md.years,
        md.total_armed_personel
    FROM
        Military md
    WHERE
        md.country_military_code = country_code;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS GetMilitaryDataByCountryCode;

-- Stored procedure for Afghanistan (AFG)
CALL GetMilitaryDataByCountryCode('AFG');

-- Stored procedure for another country, the United States (USA)
CALL GetMilitaryDataByCountryCode('USA');

SELECT * FROM poverty_militaryexpenditure;

CREATE VIEW high_military_expenditure_countries AS
SELECT
    country_military_code
FROM
    military_details
WHERE
    military_expenditure_share_gdp >= 3;
    
CREATE VIEW low_military_expenditure_countries AS
SELECT
    country_code
FROM
    poverty_militaryexpenditure
WHERE
    military_expenditure_share_gdp < 1;
    
   
SELECT
    h.country_military_code
FROM
    high_military_expenditure_countries h
LEFT JOIN
    low_military_expenditure_countries l ON h.country_military_code = l.country_code
WHERE
    l.country_code IS NULL;    
    
SELECT
    country_military_code
FROM
    high_military_expenditure_countries
WHERE
    country_military_code NOT IN (
        SELECT
            country_code
        FROM
            low_military_expenditure_countries
    );    
    
SELECT *
FROM Terrorism_Happiness
WHERE country_name IN (
    SELECT country_happiness_name
    FROM happiness
    WHERE happiness_rate_out_of_10 >= 7.0
);    
    
SELECT *
FROM Terrorism_Happiness t
WHERE EXISTS (
    SELECT 1
    FROM happiness h
    WHERE h.country_happiness_name = t.country_name
    AND h.happiness_rate_out_of_10 >= 7.0
);    

SELECT * FROM military_details;

SELECT country_military_name,
       COUNT(years) as number_of_years,
       AVG(total_armed_personel) as average_personel,
       SUM(military_expenditure) as total_expenditure,
       MIN(armed_personel_share_pop) as min_personel_share_pop,
       MAX(military_expenditure_share_gdp) as max_expenditure_share_gdp
FROM military_details
GROUP BY country_military_name
HAVING COUNT(years) >= 2 AND MAX(military_expenditure_share_gdp) >= 1;

SELECT country_military_name,
       COUNT(years) as number_of_years,
       AVG(total_armed_personel) as average_personel,
       SUM(military_expenditure) as total_expenditure,
       MIN(armed_personel_share_labor) as min_personel_share_labor,
       MAX(military_expenditure_share_gdp) as max_expenditure_share_gdp
FROM military_details
GROUP BY country_military_name
HAVING MIN(armed_personel_share_labor) >= 1 AND SUM(military_expenditure) >= 100000000;

SELECT country_military_name,
       COUNT(years) as number_of_years,
       AVG(armed_personel_share_labor) as average_personel_share_labor,
       SUM(military_expenditure) as total_expenditure,
       MIN(armed_personel_share_pop) as min_personel_share_pop,
       MAX(total_armed_personel) as max_personel
FROM military_details
GROUP BY country_military_name
HAVING AVG(armed_personel_share_labor) >= 1 AND MIN(armed_personel_share_pop) <= 0.5;


SELECT country_military_name,
       COUNT(years) as number_of_years,
       AVG(armed_personel_share_labor) as average_personel_share_labor,
       SUM(military_expenditure) as total_expenditure,
       MIN(total_armed_personel) as min_personel,
       MAX(military_expenditure_share_gdp) as max_expenditure_share_gdp
FROM military_details
GROUP BY country_military_name
HAVING MAX(military_expenditure_share_gdp) >= 2 AND COUNT(years) <= 50;
