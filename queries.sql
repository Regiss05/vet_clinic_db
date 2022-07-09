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

-- Who owns the most animals.
SELECT  owners.full_name as Who_Owns_most_animals, 
COUNT(animals.owner_id) as Animal_Highest_Count
FROM animals INNER JOIN owners ON animals.owner_id = owners.id
WHERE animals.owner_id = owners.id 
GROUP BY Who_Owns_most_animals
ORDER BY Animal_Highest_Count DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher
SELECT vets.name as VET_NAME, animals.name as Animal_Last_Seen,
visits.date_of_visit FROM vets JOIN visits ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
WHERE vets.name ='William Tatcher' ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see
SELECT COUNT(*) as count_Animals_seen_by_Stephanie_Mendez from vets JOIN
visits ON vets.id = visits.vets_id WHERE name='Stephanie Mendez'

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name as vets_name, species.name as specialization
from vets LEFT JOIN specializations ON specializations.vets_id = vets.id
LEFT JOIN  species ON specializations.species_id = species.id;

-- all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name as animal_name ,date_of_visit from animals 
JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id
WHERE vets.name= 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?.
SELECT animals.name as Animal_Name, COUNT(*) as heighest_visit from animals
JOIN visits ON visits.animals_id = animals.id
GROUP BY animals.name
ORDER BY heighest_visit DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name, animals.name, date_of_visit FROM vets
JOIN visits ON vets.id=visits.vets_id
JOIN animals ON animals.id= visits.animals_id 
WHERE vets.name ='Maisy Smith' ORDER BY visits.date_of_visit ASC LIMIT 1;

-- SELECT date_of_visit as Most_Recent_visit, 
animals.date_of_birth as animal_dob, animals.escape_attempts,
animals.neutered as neutered_status, animals.weight_kg as animal_weight,
vets.name as vet_name, vets.age as vet_age, vets.date_of_graduation
FROM visits JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
ORDER BY date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) as Count_visits_with_vet_without_specialization
FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
JOIN specializations ON specializations.vets_id = visits.vets_id
WHERE animals.species_id != specializations.species_id;