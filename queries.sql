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

-- What animals belong to Melody Pond?
 SELECT animals.name as Animal_Name, owners.full_name as Animal_Owner
 FROM animals INNER JOIN owners ON animals.owners_id = owners.id
 WHERE owners.full_name ='Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name as Animal_Name, 
species.name as Animal_Species
FROM animals INNER JOIN 
species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

--List all owners and their animals, remember to include those that don't own any animal
SELECT owners.full_name as Owner, 
animals.name as Animal_Name
FROM owners INNER JOIN 
animals ON owners.id = animals.owners_id;

--animals are there per species
SELECT COUNT(animals.species_id) as Total_Animals_Per_Species, 
species.name as Species_Name
FROM animals INNER JOIN 
species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon' OR 
species.name = 'Digimon'
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT  animals.name as Animal_Name, 
owners.full_name as Owned_by, species.name as Species_Name
FROM animals INNER JOIN  species ON animals.species_id = species.id 
 INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name= 'Digimon'
ORDER BY Animal_Name ASC; 

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT  animals.name as Animal_Name, animals.escape_attempts,
owners.full_name as Owned_By
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0 
ORDER BY Animal_Name ASC; 

