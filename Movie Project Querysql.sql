Select *  From 
PortfolioProject..movies
Order By NewYear2 DESC



--1. Total number of movies according to rating

Select rating,Count(*) As TotalMovies
From PortfolioProject..movies
Where rating is Not  null
Group by rating
order by 2 Desc

--2 Total number of movies based on Genre
Select genre,Count(genre) As TotalGenreMovies,Round(Avg(score),2)As AvgRating,Sum(votes)Sumofvotes
From PortfolioProject..movies
Group by genre
Order by Sumofvotes Desc

--3 Movies with highest number of votes
Select name,votes
From PortfolioProject..movies
Order by name
--4 Movies with highest rum time
Select name,Round((runtime/60),2)as Runtime
From PortfolioProject..movies
order by Runtime Desc

--5 Movies with highest budget
Select name,Budget
From PortfolioProject..movies
Order by budget Desc


--6 Number of movies per year
Select NewYear2,COUNT(*)As MoviePerYear
From PortfolioProject..movies
--where NewYear2 Is Not NULL
Group By NewYear2
Order By NewYear2 ASc


Select Count(NewYear2)
From PortfolioProject..movies

--7 Movie on the basis of country

Select country,COUNT(country)As MoviePerCountry
From PortfolioProject..movies
where country Is Not NULL
Group By country
Order By MoviePerCountry DESC





SELECT rating, 
Coalesce(rating,'Not Rated')
From PortfolioProject..movies

