--------------------------------------------
-- LinkedIn Learning -----------------------
-- Advanced SQL - Query Processing Part 2 --
-- Ami Levin 2020 --------------------------
-- .\Chapter2\Solution.sql -----------------
--------------------------------------------

-- GitHub
https://github.com/ami-levin/LinkedIn/tree/master/Query%20Processing%20Part%202/Chapter2%20-%20Advanced%20Joins/Solution.sql

-- DBFiddle UK
/*SQL Server*/	https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=ca55e3fd2a2e01b4b1fac19b9da04dc9&hide=3


/*
   _____	   __	   __  _		   
  / ___/____  / /_	__/ /_(_)___  ____ 
  \__ \/ __ \/ / / / / __/ / __ \/ __ \
 ___/ / /_/ / / /_/ / /_/ / /_/ / / / /
/____/\____/_/\__,_/\__/_/\____/_/ /_/ 
									   
*/

-- In case you forgot to cleanup the previous demos...
DELETE FROM Adoptions WHERE Name = 'Duplicate';
DELETE FROM Animals WHERE Name IN ('Duplicate', 'Ferris');

-- 1. Start with a simple CROSS JOIN
SELECT	*
FROM	Animals AS A1
		CROSS JOIN
		Animals AS A2;

-- 2. Filter for same species and breed
SELECT	*
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
			ON	A1.Species = A2.Species
				AND
				A1.Breed = A2.Breed;

-- 3. Replace * with required column names
SELECT	A1.Species,
		A1.Breed AS Breed,
		A1.Name AS Male,
		A2.Name AS Female
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
			ON	A1.Species = A2.Species
				AND
				A1.Breed = A2.Breed
ORDER BY 	A1.Species, 
			A1.Breed;

-- 4. Add predicate or comment for future developers
SELECT	A1.Species,
		A1.Breed AS Breed,
		A1.Name AS Male,
		A2.Name AS Female
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
			ON	A1.Species = A2.Species
				AND
				A1.Breed = A2.Breed -- Removes NULL breeds
				-- AND 
				-- A1.Breed IS NOT NULL -- 
ORDER BY 	A1.Species, 
			A1.Breed;

-- 5. Don't match animals with themselves.
SELECT	A1.Species,
		A1.Breed AS Breed,
		A1.Name AS Male,
		A2.Name AS Female
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
			ON	A1.Species = A2.Species
				AND
				A1.Breed = A2.Breed -- Removes NULL breeds
				AND
				A1.Name <> A2.Name
ORDER BY 	A1.Species, 
			A1.Breed;

-- 6. Solution
SELECT	A1.Species,
		A1.Breed AS Breed,
		A1.Name AS Male,
		A2.Name AS Female
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
		ON	A1.Species = A2.Species
			AND
			A1.Breed = A2.Breed -- Removes NULL breeds
			AND
			A1.Name <> A2.Name
			AND
			A1.Gender = 'M'
			AND 
			A2.Gender = 'F'
ORDER BY 	A1.Species, 
			A1.Breed;

-- 7. Solution with > shortcut 
-- 	  !!! Only works if collation is dictionary based, and if case insensitive or casing is consistent !!!
SELECT	A1.Species,
		A1.Breed AS Breed,
		A1.Name AS Male,
		A2.Name AS Female
FROM	Animals AS A1
		INNER JOIN
		Animals AS A2
		ON	A1.Species = A2.Species
			AND
			A1.Breed = A2.Breed -- Removes NULL breeds
			AND
			A1.Name <> A2.Name
			AND
			A1.Gender > A2.Gender
ORDER BY 	A1.Species, 
			A1.Breed;

/*
  ________  ________   _______   ______ 
 /_  __/ / / / ____/  / ____/ | / / __ \
  / / / /_/ / __/    / __/ /  |/ / / / /
 / / / __  / /___   / /___/ /|  / /_/ / 
/_/ /_/ /_/_____/  /_____/_/ |_/_____/  
                                        
*/


Hi,
Was just curious if Name and Species are used to identify every animal and we have compared that one of the animal in join should be a male and other should be a female, so why is the name comparison required. As no two animals can have same name and same species as per DB.

SELECT A1.Species, A1.Breed, A1.Name, A2.Name 
FROM ANIMALS A1
inner join ANIMALS A2
ON A1.Gender='M' and A2.GENDER='F'
AND A1.Species = A2.Species and A1.Breed = A2.Breed
order by A1.Species, A1.Breed

Not sure, if I understood it correctly but just wanted to know when the above code may fail as it gives the same set of records.

Thanks!
