/*Queries that provide answers to the questions from all projects.*/

-- Query to select data between 2016 and 2019
SELECT * FROM animals;
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '1/1/2016' AND '12/31/2019';
SELECT * FROM animals WHERE escape_attempts < 3 AND neutered = 'true';
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
