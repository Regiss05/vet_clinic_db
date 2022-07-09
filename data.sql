/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
  VALUES 
('Agumon', 'Feb 3, 2020', 0, true, 10.23),
('Gabumon', 'Nov 15, 2018', 2, true, 8),
('Pikachu', 'Jan 7, 2021', 1, false, 15.04),
('Devimon', 'May 12, 2017', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
  VALUES 
('Charmander', 'Feb 8, 2020', 0, false, 11),
('Plantmon', 'Nov 15, 2021', 2, true, 5.7),
('Squirtle', 'Apr 2, 1993', 3, false, 12.13),
('Angemon', 'Jun 12, 2005', 1, true, 45),
('Boarmon', 'Jun 7, 2005', 7, true, 20.4),
('Blossom', 'Oct 13, 1998', 3, true, 17),
('Ditto', 'May 14, 2022', 4, true, 22);

INSERT INTO owners (full_name, age) 
  VALUES 
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name) 
  VALUES 
('Pokemon'),
('Digimon');

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