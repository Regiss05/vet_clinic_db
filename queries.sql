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

-- user transaction to rename to redo the change
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

-- add data into species field using transaction update
BEGIN
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon'
UPDATE animals SET species = 'pokemon' WHERE species IS null
COMMIT
SELECT * FROM animals

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals
ROLLBACK;
SELECT * FROM animals

-- Add and delete data using transaction
BEGIN;
DELETE FROM animals WHERE date_of_birth > '1/1/2022';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals

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

-- Modify your inserted animals so it includes the species_id value:
--If the name ends in "mon" it will be Digimon
UPDATE animals SET species_id = (
	SELECT id FROM species WHERE name = 'Digimon'
) WHERE name LIKE '%mon';
-- All other animals are Pokemon
UPDATE animals SET species_id = (
	SELECT id FROM species WHERE name = 'Pokemon'
) WHERE name NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') 
WHERE name = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') 
WHERE name = 'Gabumon' OR name = 'Pikachu';
-- Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') 
WHERE name = 'Devimon' OR name = 'Plantmon';
-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') 
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') 
WHERE name = 'Angemon' OR name = 'Boarmon';

SELECT * FROM owners
SELECT * FROM animals