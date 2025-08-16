-- Data Cleaning
select  *
from layoffs;

-- copy and paste the raw data to the staging table
-- this is to ensure the original data isn't interfered with
Create table layoffs_staging
like layoffs;
insert layoffs_staging
select *
from layoffs;

-- Objectives
-- 1. Remove duplicates
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions ) as row_num
from layoffs_staging;

with duplicate_cte as 
(
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions ) as row_num
from layoffs_staging
)
-- if they have duplicate label the row_num as 2
select *
from duplicate_cte
where row_num > 1;
-- confirmation
select *
from layoffs_staging
where company = 'Casper'; # this currently has 1 other duplicate

select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions ) as row_num
from layoffs_staging;

with duplicate_cte as 
(
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions ) as row_num
from layoffs_staging
)
-- if they have duplicate label the row_num as 2
delete
from duplicate_cte
where row_num > 1;

-- create another staging table to add the row_num column and use it to delete the dublipacte
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2
where row_num >1;

insert into layoffs_staging2
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions ) as row_num
from layoffs_staging;
-- delete
delete 
from layoffs_staging2
where row_num >1;
select *
from layoffs_staging2;


-- 2. Standardize the data : finding issues and fixing them

select company, trim(company) 
from layoffs_staging2;
-- removed the whitespace
update layoffs_staging2
set company = trim(company);

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';


-- 3. Null values/ blank values
-- 4. Remove unnecesarry columns and rows













































































































































































































































































































































































































