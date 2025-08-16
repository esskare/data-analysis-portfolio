-- Explatory Data Analysis: understand the scale, timing, geography, and company context of layoffs.

select *
from layoffs_staging2;

-- Identifies the largest layoff event (absolute numbers and % of workforce)
select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

-- Shows companies that laid off their entire workforce, ordered by how much funding they had raised.
select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

-- Aggregates layoffs by company to find the top contributors to layoffs.
select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

-- Finds the earliest and latest dates of layoffs in the dataset.
select min(`date`), max(`date`)
from layoffs_staging2;

-- Summarizes layoffs by country to see which regions were most affected.
select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

-- Shows layoffs per year, highlighting peaks/trends over time.
select year( `date`), sum(total_laid_off)
from layoffs_staging2
group by year( `date`)
order by 1 desc;

-- Aggregates layoffs by company stage (e.g., startup, growth, IPO) to see which stages were hit hardest.
select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

-- Helps reveal trends over time, instead of just yearly aggregates (rolling sum)
select substring(`date`,1,7) as `Month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 asc
;

-- Creates a rolling (cumulative) total of layoffs across months.
with Rolling_Total as (
select substring(`date`,1,7) as `Month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 asc
)
select `Month`, total_off,
sum(total_off) over(order by `Month`)as rolling_total
from Rolling_Total;

-- Breaks layoffs down by company + year, so you can see when each company was most affected.
select company,year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc;

-- Final result: A list of the Top 5 companies per year with the most layoffs.
with Company_Year (company, years, total_laid_off)as (
select company,year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), Company_Year_Rank as
(
select *, dense_rank() over(partition by years
order by total_laid_off desc) as Ranking
from Company_Year
where years is not null
) 
select *
from Company_Year_Rank
where Ranking <=5
;

















