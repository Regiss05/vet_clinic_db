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
