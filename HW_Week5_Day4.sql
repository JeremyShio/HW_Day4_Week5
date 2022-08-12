-- Week 5 - Day 4 - Homework Exercises !(•̀ᴗ•́)و✧




-- ORDER OF CLAUSES:
-- SELECT 
-- FROM 
-- JOIN
-- ON
-- WHERE 
-- GROUP BY 
-- HAVING 
-- ORDER BY 
-- OFFSET 
-- LIMIT




-- 1. Create a Stored Procedure that will insert a new film into the film table with the following arguments: title, description, release_year, language_id, rental_duration, rental_rate, length, replace_cost, rating


SELECT * FROM film;


INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, rental_length, replace_cost, rating, last_update);


CREATE OR REPLACE PROCEDURE magically_add_film (
	title VARCHAR(255),
	description VARCHAR,
	release_year INTEGER,
	language_id INTEGER,
	rental_duration INTEGER,
	rental_rate NUMERIC(4,2),
	rental_length INTEGER,
	replace_cost NUMERIC(5,2),
	rating VARCHAR(5),
	last_update TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, rental_length, replace_cost, rating, last_update)
	VALUES (title, description, release_year, language_id, rental_duration, rental_rate, rental_length, replace_cost, rating, NOW());
END;
$$;


	--title VARCHAR(255),
	--description VARCHAR,
	--release_year INTEGER,
	--language_id INTEGER,
	--rental_duration INTEGER,
	--rental_rate NUMERIC(4,2),
	--rental_length INTEGER,
	--replace_cost NUMERIC(5,2),
	--rating VARCHAR(5),
	--last_update TIMESTAMP


EXEC magically_add_film (
	'Person With A Story',
	'The movie opens with a young woman in prison, but this is just the beginning... When suddenly, the president of the Galactic Federation hires her as private detective. Due to increasing other-worldly tensions, help is needed in desciphering the location of an extra-terrestrial nuclear weapons dealer. His actions have been... Watch now to find out!',
	2021,
	1,
	7,
	19.99,
	98,
	117.99,
	'NC-17'
);




-- 2. Create a Stored Function that will take in a category_id and return the number of films in that category


SELECT * FROM film_category;
SELECT * FROM film;


CREATE OR REPLACE FUNCTION mysteriously_count_films_category (num INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE film_count INTEGER;
BEGIN 
	SELECT COUNT(*) INTO film_count
	FROM film_category 
	WHERE category_id LIKE CONCAT(num,
'%%');
	RETURN film_count;
END;
$$;


SELECT mysteriously_count_films_category('7')
