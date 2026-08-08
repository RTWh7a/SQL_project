-- SQL Data claening project 
-- 1)Remove duplicate
-- 2)Stander data
-- 3)Remove Missing value
-- 4)Remove any unwanted columns
-- Understand my data 
SELECT * FROM layoffs;

-- Create table for any emegency
CREATE TABLE layoffs_stating
LIKE layoffs;

SELECT * FROM layoffs_stating;

INSERT layoffs_stating
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_stating;

-- 1.Remove duplicate
with duplicate_cte as
( 
select *,
row_number() over(partition by company, total_laid_off, percentage_laid_off,`date`,stage) as row_num
from layoffs_stating
)
select *
from duplicate_cte
where row_num > 1;

CREATE TABLE `layoffs_stating2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_stating2
select *,
row_number() over(partition by company, total_laid_off, percentage_laid_off,`date`,stage) as row_num
from layoffs_stating;

DELETE 
FROM layoffs_stating2
WHERE row_num>1;

-- Stander data
SELECT DISTINCT(TRIM(company))
FROM layoffs_stating2;

UPDATE layoffs_stating2
SET company=TRIM(company);

SELECT industry
FROM layoffs_stating2;

SELECT industry
FROM layoffs_stating2
ORDER BY 1;

SELECT DISTINCT(industry)
FROM layoffs_stating2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_stating2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

select *
from layoffs_stating2
where industry like 'Cry%';

SELECT DISTINCT(country)
FROM layoffs_stating2
ORDER BY 1;

SELECT country , TRIM(TRAILING '_' FROM country)
FROM layoffs_stating2
ORDER BY 1;

select * 
from layoffs_stating2;

UPDATE layoffs_stating2
SET country = TRIM(TRAILING '_' FROM country)
WHERE country LIKE 'United States%';

SELECT * FROM layoffs_stating2
WHERE country LIKE 'United States%';

select `date`,
str_to_date(`date`,'%m/%d/%y')
from layoffs_stating2;

WITH cte AS(
SELECT `date`,str_to_date(`date`,'%m/%d/%y') AS new_date
FROM layoffs_stating2
)
SELECT *
FROM cte;

update layoffs_stating2
set `date` = str_to_date(`date`,'%m/%d/%y');

ALTER TABLE layoffs_stating2
MODIFY COLUMN `date` DATE;

-- find missing values
SELECT 
    *
FROM
    layoffs_stating2 ls2
WHERE
    ls2.total_laid_off IS NULL AND ls2.percentage_laid_off is null;
    
select *
from layoffs_stating2 st1
join layoffs_stating2 st2
on st1.company = st2.company and st1.location = st2.location;

select t1.industry , t2.industry 
from layoffs_stating2 t1
join layoffs_stating2 t2
 on t1.company = t2.company
where (t1.industry is null or t1.industry = '') 
and t2.industry is not null; 

update layoffs_stating2 t
set t.industry = ''
where t.industry is null;

select industry
from layoffs_stating2;
update layoffs_stating2 t1
join layoffs_stating2 t2
 on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;

select t1.industry , t2.industry 
from layoffs_stating2 t1
join layoffs_stating2 t2
 on t1.company = t2.company;
 
SELECT 
    *
FROM
    layoffs_stating2 ls2
WHERE
    ls2.total_laid_off IS NULL AND ls2.percentage_laid_off is null;
    
DELETE
FROM
layoffs_stating2 ls2
WHERE ls2.total_laid_off IS NULL 
AND ls2.percentage_laid_off IS NULL;

ALTER TABLE layoffs_stating2
DROP COLUMN row_num;

-- EDA analysis
SELECT *
FROM layoffs_stating2;

SELECT *
FROM layoffs_stating2 t
WHERE t.percentage_laid_off =1;

SELECT company, SUM(total_laid_off)
FROM layoffs_stating2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`) , max(`date`)
FROM layoffs_stating2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_stating2
GROUP BY industry
ORDER BY 2 DESC;

SELECT t.country, SUM(total_laid_off)
FROM layoffs_stating2 t
GROUP BY country
ORDER BY 2 DESC;
