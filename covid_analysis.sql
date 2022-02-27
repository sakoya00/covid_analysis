--COVID fatality rate by country
SELECT location, date, population, total_cases, total_deaths, CAST(total_deaths as FLOAT)/ total_cases*100 as fatality_rate
FROM covid_deaths 
--Sub in your location below
--WHERE location is 'United States'
ORDER BY 1,2;

--Highest fatality rate
SELECT location, date, population, total_cases, total_deaths, MAX(CAST(total_deaths as FLOAT)/ total_cases*100) as fatality_rate
FROM covid_deaths 
--Sub in your location below
--WHERE location is 'United States'
ORDER BY 1,2;

--Percentage of population which contracted COVID
SELECT location, date, population, total_cases, CAST(total_cases as FLOAT)/population*100 as cases_percentage
FROM covid_deaths 
--Sub in your location below
--WHERE location is 'United States'
ORDER BY 1,2;

--Highest contraction rate by country
SELECT location, date, population, MAX(total_cases) as max_cases, CAST(MAX(total_cases) as FLOAT)/population*100 as cases_percentage
FROM covid_deaths 
GROUP BY location, population
ORDER BY cases_percentage desc;

--Deaths by continent
SELECT continent, MAX(CAST(total_deaths as FLOAT)) as max_deaths
FROM covid_deaths 
WHERE continent IS NOT NULL
GROUP BY continent;

--Total vaccinations per population by location
--Check version of SQLiteStudio to make sure it can run window functions like PARTITION BY
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(cv.new_vaccinations) OVER (PARTITION BY cd.location, cd.date)
FROM covid_deaths cd
JOIN covid_vax cv
    ON cd.location = cv.location
    AND cd.date = cv.date
WHERE cv.new_vaccinations IS NOT ''
AND cd.continent IS NOT NULL
ORDER BY 2,3

