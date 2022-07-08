/*Queries that provide answers to the questions from all projects.*/

-- Query to select data between 2016 and 2019
SELECT * FROM animals;
-- Query to select data which name ends with mon
SELECT * FROM animals WHERE name LIKE '%mon';
-- Query to select data where birth daya is between 2016 and 2019
SELECT * FROM animals WHERE date_of_birth BETWEEN '1/1/2016' AND '12/31/2019';
-- query to select data where escape attempts is less than 3 and is neutered
SELECT * FROM animals WHERE escape_attempts < 3 AND neutered = 'true';
-- query to select data which name is agumon or Pikachu
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
-- query to display escape attempts number of animals which has more than 10.h kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
-- query to select all animals which are neutered
SELECT * FROM animals WHERE neutered = 'true';
-- query to select all animals except Gabumon
SELECT * FROM animals WHERE name != 'Gabumon';
-- query to select all animals which are between 10.4 and 17.3 kg
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
-- display all animals
SELECT * FROM animals
-- How many animals have never tried to escape?
SELECT * FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG (weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT * FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
-- What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG (weight_kg) FROM animals WHERE date_of_birth BETWEEN '1/1/1990' AND '1/1/2000';