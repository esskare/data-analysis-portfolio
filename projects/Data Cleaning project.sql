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

select distinct company
from layoffs_staging2
order by 1;
-- remove the whitespace
select company, trim(company) 
from layoffs_staging2;
update layoffs_staging2
set company = trim(company);

select distinct industry
from layoffs_staging2
order by 1;
-- grouped into similar industry name i.e. (crypto & cryptocurrency) = crypto
select *
from layoffs_staging2
where industry like 'Crypto%';
update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct country
from layoffs_staging2
order by 1;
--  #look for the period at the end and trim
select distinct country, trim(trailing '.' from country)
from layoffs_staging2;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`
from layoffs_staging2;
-- taking the text and converting it into the date format
select `date`, 
str_to_date(`date`, '%m/%d/%Y') 
from layoffs_staging2;
update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

-- change the data type of date from text to datetime
alter table layoffs_staging2
modify column `date` date;


-- 3. Null values/ blank values
select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- setting the blanks to null for recognition
update layoffs_staging2
set industry = null
where industry = ' ';

select *
from layoffs_staging2
where industry is null
or industry = '';

-- populating the empty rows
select *
from layoffs_staging2
where company = 'Airbnb';

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

-- 4. Remove unnecesarry columns and rows

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;
alter table layoffs_staging2
drop column row_num; 











































































































































































































































































































































































































