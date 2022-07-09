/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

-- Add new column
ALTER TABLE animals ADD species VARCHAR(100);

CREATE TABLE owners (
  	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species (
  	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100)
)

-- delete column species
ALTER TABLE animals DROP COLUMN species;

-- Add column and grent a foreign key to species table
ALTER TABLE animals ADD species_id INT;
 ALTER TABLE animals
 ADD CONSTRAINT species_id
 FOREIGN KEY(species_id) REFERENCES species(id);

-- Add column and grent a foreign key to owners table
ALTER TABLE animals ADD owner_id INT
ALTER TABLE animals
 ADD CONSTRAINT owner_id
 FOREIGN KEY(owner_id) REFERENCES owners(id);

--  Create a table named vets
 CREATE TABLE vets(
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR(200),
   age INT,
   date_of_graduation DATE
);

-- Create specialization table
CREATE TABLE specializations(
    specialty_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    species_id INT REFERENCES species(id),
    vets_id INT REFERENCES vets(id)
);

-- create visits table
CREATE TABLE visits(
    visits_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id)
);

/*Project 4: Insert the following data for specialties: */
INSERT INTO specializations(species_id, vets_id)
VALUES((SELECT id FROM species WHERE name = 'Pokemon'),
(SELECT id FROM vets WHERE name = 'William Tatcher')),
((SELECT id FROM species WHERE name = 'Digimon'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
((SELECT id FROM species WHERE name = 'Digimon'),
(SELECT id FROM vets WHERE name = 'Jack Harkness'));

-- Insert the following data for visits
INSERT INTO visits(animals_id, vets_id, date_of_visit)
VALUES((SELECT id  FROM animals WHERE name ='Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'May-24-2020'),
       ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'Jul-22-2020'),
       ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Feb-02-2021'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Jan-05-2020'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Mar-08-2020'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'May-14-2020'),
       ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May-04-2021'),
       ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Feb-24-2021'),
       ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Dec-21-2019'),
       ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'Aug-10-2020'),
       ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Apr-07-2021'),
       ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'Sep-29-2019'),
       ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Oct-03-2020'),
       ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Nov-04-2020'),
       ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Jan-24-2019'),
       ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'May-15-2019'),
       ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Feb-27-2020'),
       ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Aug-03-2020'),
       ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May-24-2020'),
       ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'Jan-11-2021');