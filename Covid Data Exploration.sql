
SELECT * 
FROM ProtfolioProject..CovidDeath
Where continent Is not null
ORDER BY 3,4

--SELECT * 
--FROM ProtfolioProject..CovidVaccination
--ORDER BY 3,4

--Select the data that we are going to use

SELECT Location,date,total_cases,new_cases,total_deaths,population
FROM ProtfolioProject..CovidDeath
Where continent Is not null
Order by 1,2

--Now we will look at the Total_cases VS Total_deaths

SELECT Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM ProtfolioProject..CovidDeath
Where location LIKE '%states%'
And  continent Is not null
Order by 1,2

--Looking at the Total Cases Vs Total Population
--Shows What percentage of population got Covid

SELECT Location,date,population,total_cases,(total_cases/population)*100 as PercentagePoulationInfected
FROM ProtfolioProject..CovidDeath
--Where location LIKE '%states%'
Order by 1,2

--Which Country have the most Covid cases


SELECT Location,population,MAX(total_cases) as HighestInfectionCount,Max((total_cases/population))*100 as PercentagePoulationInfected 
FROM ProtfolioProject..CovidDeath
--Where location LIKE '%states%'
Group BY Location,population
Order by PercentagePoulationInfected Desc

--  Showing the country with Highest Death Count per Population 

SELECT Location,MAX(Cast(total_deaths as int)) as TotalDeathCount
FROM ProtfolioProject..CovidDeath
--Where location LIKE '%states%'
Where continent Is not null
Group BY Location
Order by TotalDeathCount Desc

--Let's Break down by Continent

--Let look which continent have the highest Death Count

SELECT continent,MAX(Cast(total_deaths as int)) as TotalDeathCount
FROM ProtfolioProject..CovidDeath
--Where location LIKE '%states%'
Where continent Is not null
Group BY continent
Order by TotalDeathCount Desc

--GLOBAL NUMBER
-- we are checking the cases and death on the basis of date

SELECT date,SUM(new_cases) as total_cases,SUM(cast(new_deaths as int))as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM ProtfolioProject..CovidDeath
--Where location LIKE '%states%'
Where  continent Is not null
Group by date
Order by 1,2

--Total world population got infected and the total number of death

SELECT SUM(new_cases) as total_cases,SUM(cast(new_deaths as int))as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM ProtfolioProject..CovidDeath
--Where location LIKE '%states%'
Where  continent Is not null
Order by 1,2



--Looking at the Total Population who  got vaccinated

Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.date)
as RollingPeopleVaccinated
FROM ProtfolioProject..CovidDeath dea
JOIN  ProtfolioProject..CovidVaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
where dea.continent is not null 
order by 2,3

--Use CTC 

With PopvsVac (Continent,Location,Date,Population ,New_vaccinations,RollingPeopleVaccinated)
as
(
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.date)
as RollingPeopleVaccinated
FROM ProtfolioProject..CovidDeath dea
JOIN  ProtfolioProject..CovidVaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *,(RollingPeopleVaccinated/Population)*100 From 
PopvsVac
Order by 2,3

--Temp Table
Drop Table if exists #PercentPeopleVaccinated
Create Table #PercentPeopleVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccination numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPeopleVaccinated
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.date)
as RollingPeopleVaccinated
FROM ProtfolioProject..CovidDeath dea
JOIN  ProtfolioProject..CovidVaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
--where dea.continent is not null 
--order by 2,3


Select *,(RollingPeopleVaccinated/Population)*100 From 
#PercentPeopleVaccinated

--Creating a view to store data for later visualization



Create View PercentPeopleVaccinated as
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location order by dea.location, dea.date)
as RollingPeopleVaccinated
FROM ProtfolioProject..CovidDeath dea
JOIN  ProtfolioProject..CovidVaccination vac
	ON dea.location = vac.location
	AND dea.date = vac.date
where dea.continent is not null  And 
new_vaccinations is not null
--order by 2,3


SELECT * FROM PercentPeopleVaccinated
Order by 2,3